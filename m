Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC87C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 11:51:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65329206FA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5FCLmAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65329206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3918086D25;
	Tue,  1 Sep 2020 11:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blABEHnQ0nuw; Tue,  1 Sep 2020 11:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9E0F86D23;
	Tue,  1 Sep 2020 11:51:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2284C07FF;
	Tue,  1 Sep 2020 11:51:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A864C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 11:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2D754861F1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 11:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYVTYQ-FWJyk for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 11:51:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4881686099
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598961099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESRP55Rg69yEwDMYjivqnTqvuKK7oN+Pled0DdWVsmg=;
 b=R5FCLmAFqqd9FjLUQDg07EV9NH/ZFVRvlChjkgGZAnrztzIDmIsosnqKO1QnaFDgn2n2jA
 vT0E/XmAHVcg3ZnU82JZXScIVRMPYP73T2uDU7SecHyrKucLYGX93DKCUT1L/maMahozix
 eFP8jH3E8jdBJs0t66mnfwuuSbgOvPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-mmEQVsJONMuZ0kRtnv8r2Q-1; Tue, 01 Sep 2020 07:51:35 -0400
X-MC-Unique: mmEQVsJONMuZ0kRtnv8r2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652C510ABDAB;
 Tue,  1 Sep 2020 11:51:33 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B908319C4F;
 Tue,  1 Sep 2020 11:51:30 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/9] iommu/ioasid: Rename ioasid_set_data()
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <cdce91cd-2f9a-36ff-ca87-7aabe3d08ec1@redhat.com>
Date: Tue, 1 Sep 2020 13:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Wu Hao <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi jacob,

On 8/22/20 6:35 AM, Jacob Pan wrote:
> Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
> struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
> token.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel/svm.c | 6 +++---
>  drivers/iommu/ioasid.c    | 6 +++---
>  include/linux/ioasid.h    | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index b6972dca2ae0..37a9beabc0ca 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -342,7 +342,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
>  		}
> -		ioasid_set_data(data->hpasid, svm);
> +		ioasid_attach_data(data->hpasid, svm);
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>  		mmput(svm->mm);
>  	}
> @@ -394,7 +394,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	list_add_rcu(&sdev->list, &svm->devs);
>   out:
>  	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
> -		ioasid_set_data(data->hpasid, NULL);
> +		ioasid_attach_data(data->hpasid, NULL);
>  		kfree(svm);
>  	}
>  
> @@ -437,7 +437,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				 * the unbind, IOMMU driver will get notified
>  				 * and perform cleanup.
>  				 */
> -				ioasid_set_data(pasid, NULL);
> +				ioasid_attach_data(pasid, NULL);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..5f63af07acd5 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -258,14 +258,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
>  EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
>  
>  /**
> - * ioasid_set_data - Set private data for an allocated ioasid
> + * ioasid_attach_data - Set private data for an allocated ioasid
>   * @ioasid: the ID to set data
>   * @data:   the private data
>   *
>   * For IOASID that is already allocated, private data can be set
>   * via this API. Future lookup can be done via ioasid_find.
>   */
> -int ioasid_set_data(ioasid_t ioasid, void *data)
> +int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	struct ioasid_data *ioasid_data;
>  	int ret = 0;
> @@ -287,7 +287,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_set_data);
> +EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
>   * ioasid_alloc - Allocate an IOASID
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..9c44947a68c8 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
> -int ioasid_set_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_data(ioasid_t ioasid, void *data);
>  
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> @@ -67,7 +67,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
>  {
>  }
>  
> -static inline int ioasid_set_data(ioasid_t ioasid, void *data)
> +static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	return -ENOTSUPP;
>  }
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
