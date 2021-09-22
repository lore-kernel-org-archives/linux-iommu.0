Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD6C433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:43:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC94610D1
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BC94610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AFAC613DD;
	Wed, 22 Sep 2021 13:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I52N_QQc0jEB; Wed, 22 Sep 2021 13:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E69B760BBF;
	Wed, 22 Sep 2021 13:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB1C8C000F;
	Wed, 22 Sep 2021 13:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5951CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F09D404FE
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4tIQbDlSKUc for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:43:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EF5640480
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632318181;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JWo7IWTXSlpZNK2XfHGpxPNo71k2+QBHUACSQR7vWo=;
 b=GHFJwUI086HVY05vs8d1cqZhdlwS/KTz1bWGtM6DD6Dn6wGR0//T+nGXZwJGO7cA2Ca4UD
 QscSiI+PN4VQWnvlAOFSYHAoahOZkGuuaJg8Al3+z975KoDz2gXZBeA3lw1vsiuBYIFxMH
 zJH6qOBkHL1m+xziZ6wEsGaousMPWCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-8JKOf0_yPiyTS4aHAxNbLg-1; Wed, 22 Sep 2021 09:42:59 -0400
X-MC-Unique: 8JKOf0_yPiyTS4aHAxNbLg-1
Received: by mail-wr1-f71.google.com with SMTP id
 s13-20020a5d69cd000000b00159d49442cbso2198218wrw.13
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+JWo7IWTXSlpZNK2XfHGpxPNo71k2+QBHUACSQR7vWo=;
 b=44tS7MfAXTPGGUF3qVvnB40iC0cjlOWN3z/zhtoSpTdj2YuF16CPu/rlknhFvPMbqb
 lRYFUNBDkL9P8qa22YlfG881wQ+JC1qhHtwgS7QYTfKeiFovFHXDS0KB6YnsqNFZEtB8
 8m3Q2tWvh0FDpKG4PFeLtoLU1sEOFttdYGOjqZrFb/RrGN3LjYwVTQk98s1Nf/9noIn5
 Usx3+jgZ/5Ovspb9XOrp1B6ALHXlK42Av0WMAT7ppN0HXLwCW9yt8958h55UyAURVbYY
 mkEcMUycApscEBjTMmXuB9XfQKrux+pN/AHuzrYyAoqUFIIWojulLGM3YDcWnaNY5y5n
 qhow==
X-Gm-Message-State: AOAM532e5V2bVAYIO6bhdl4X6KekkIpiw87gSyji0no2Z23ndL+V/cRQ
 8sCFU8hUI4+wJdfdTWt2KXaMLiiNXES80/LOjXx9N38yFCaq5eqW2VXM1ao4HU5MM2HhHOGWjI6
 yvvixd/Zl6twbSJNUQjCRhD5EVhv91Q==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr41168341wrc.0.1632318178793; 
 Wed, 22 Sep 2021 06:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznc1KSiF5aPkuH636x53Cc3ByiW8cBM1EzDuEwJOc+UzPa3JyVYA67rj7GZoExD7VAGn/rhA==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr41168305wrc.0.1632318178583; 
 Wed, 22 Sep 2021 06:42:58 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id v8sm2207321wrt.12.2021.09.22.06.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Sep 2021 06:42:57 -0700 (PDT)
Subject: Re: [RFC 09/20] iommu: Add page size and address width attributes
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 jgg@nvidia.com, hch@lst.de, jasowang@redhat.com, joro@8bytes.org
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-10-yi.l.liu@intel.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <e158380d-cb13-c1aa-6dd6-77032fe72106@redhat.com>
Date: Wed, 22 Sep 2021 15:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-10-yi.l.liu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 9/19/21 8:38 AM, Liu Yi L wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> This exposes PAGE_SIZE and ADDR_WIDTH attributes. The iommufd could use
> them to define the IOAS.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 943de6897f56..86d34e4ce05e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -153,9 +153,13 @@ enum iommu_dev_features {
>  /**
>   * enum iommu_devattr - Per device IOMMU attributes
>   * @IOMMU_DEV_INFO_FORCE_SNOOP [bool]: IOMMU can force DMA to be snooped.
> + * @IOMMU_DEV_INFO_PAGE_SIZE [u64]: Page sizes that iommu supports.
> + * @IOMMU_DEV_INFO_ADDR_WIDTH [u32]: Address width supported.
I think this deserves additional info. What address width do we talk
about, input, output, what stage if the IOMMU does support multiple stages

Thanks

Eric
>   */
>  enum iommu_devattr {
>  	IOMMU_DEV_INFO_FORCE_SNOOP,
> +	IOMMU_DEV_INFO_PAGE_SIZE,
> +	IOMMU_DEV_INFO_ADDR_WIDTH,
>  };
>  
>  #define IOMMU_PASID_INVALID	(-1U)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
