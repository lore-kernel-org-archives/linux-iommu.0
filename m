Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB1C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 22:22:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903A1206D7
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 22:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903A1206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B7BE87740;
	Thu, 21 Nov 2019 22:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBl2ixhWEt4A; Thu, 21 Nov 2019 22:22:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12A3B876FF;
	Thu, 21 Nov 2019 22:22:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFBB0C1DD7;
	Thu, 21 Nov 2019 22:22:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 135DFC18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 22:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A48B8707B
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 22:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 991i0Z1wsLib for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 22:22:38 +0000 (UTC)
X-Greylist: delayed 00:25:01 by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0032.hostedemail.com
 [216.40.44.32])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C262D870ED
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 22:22:38 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 4E834181C9916
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 21:37:39 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 215181806ECD0;
 Thu, 21 Nov 2019 21:37:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toes80_25057537f620a
X-Filterd-Recvd-Size: 2697
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 21 Nov 2019 21:37:34 +0000 (UTC)
Message-ID: <38d4586f3aeb21bb08028525db89868acb34e9fd.camel@perches.com>
Subject: Re: [PATCH v4 8/8] iommu/vt-d: Misc macro clean up for SVM
From: Joe Perches <joe@perches.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, 
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, David
 Woodhouse <dwmw2@infradead.org>
Date: Thu, 21 Nov 2019 13:37:10 -0800
In-Reply-To: <1574371588-65634-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574371588-65634-9-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

On Thu, 2019-11-21 at 13:26 -0800, Jacob Pan wrote:
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
[]
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
[]
> +#define for_each_svm_dev(sdev, svm, d)			\
> +	list_for_each_entry((sdev), &(svm)->devs, list)	\
> +		if ((d) != (sdev)->dev) {} else
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -274,15 +278,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  				goto out;
>  			}
>  
> -			list_for_each_entry(sdev, &svm->devs, list) {
> -				if (dev == sdev->dev) {
> -					if (sdev->ops != ops) {
> -						ret = -EBUSY;
> -						goto out;
> -					}
> -					sdev->users++;
> -					goto success;
> +			for_each_svm_dev(sdev, svm, dev) {
> +				if (sdev->ops != ops) {
> +					ret = -EBUSY;
> +					goto out;
>  				}
> +				sdev->users++;
> +				goto success;
>  			}

I think this does not read better as this is now a
for_each loop that exits the loop on the first match.

>  
>  			break;
> @@ -427,43 +429,36 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  		goto out;
>  	}
>  
> -	if (!svm)
> -		goto out;
> -
> -	list_for_each_entry(sdev, &svm->devs, list) {
[]
> +	for_each_svm_dev(sdev, svm, dev) {

I think this should not remove the !svm test above.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
