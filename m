Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EAC10DCE
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 01:42:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E436820722
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 01:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E436820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B90A888026;
	Tue, 24 Mar 2020 01:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkLSSP5BBy5k; Tue, 24 Mar 2020 01:42:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F157787FF7;
	Tue, 24 Mar 2020 01:42:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D31B4C1AE2;
	Tue, 24 Mar 2020 01:42:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B605C0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5473D86E21
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L09aju5DiiVA for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 01:42:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 868F086DCF
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:42:29 +0000 (UTC)
IronPort-SDR: NSZ4tTDbw9UxRV31lmk5FLbF1M8JsLZrRz7IWwGstpJPrsQbgqVa/NSrQ289LcYUpGbB8aIR/o
 C7FcwFXCkAdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 18:42:28 -0700
IronPort-SDR: LefSmsp92s2IYF/PXnr6Ipuk/XOB1mRv7a3IU3qijkzj/XlZb1QGzvYjNjxIF9jCqaFVGqPRmz
 mqkp44TBM4QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="264976626"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.83])
 ([10.254.208.83])
 by orsmga002.jf.intel.com with ESMTP; 23 Mar 2020 18:42:22 -0700
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
To: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200320092955.GA1702630@myrica> <20200323230113.GA84386@otc-nc-03>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6cc2f1ea-5a7d-eeab-b50c-5b464098de6b@linux.intel.com>
Date: Tue, 24 Mar 2020 09:42:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323230113.GA84386@otc-nc-03>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 "Lu, Baolu" <baolu.lu@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020/3/24 7:01, Raj, Ashok wrote:
> Hi Jean
> 
> On Fri, Mar 20, 2020 at 10:29:55AM +0100, Jean-Philippe Brucker wrote:
>>> +#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
>>> +struct iommu_sva *
>>> +intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>>> +{
>>> +	struct iommu_sva *sva = ERR_PTR(-EINVAL);
>>> +	struct intel_svm_dev *sdev = NULL;
>>> +	int flags = 0;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
>>> +	 * It will require shared SVM data structures, i.e. combine io_mm
>>> +	 * and intel_svm etc.
>>> +	 */
>>> +	if (drvdata)
>>> +		flags = *(int *)drvdata;
>>
>> drvdata is more for storing device driver contexts that can be passed to
>> iommu_sva_ops, but I get that this is temporary.
>>
>> As usual I'm dreading supervisor mode making it into the common API. What
>> are your plans regarding SUPERVISOR_MODE and PRIVATE_PASID flags?  The
>> previous discussion on the subject [1] had me hoping that you could
>> replace supervisor mode with normal mappings (auxiliary domains?)
>> I'm less worried about PRIVATE_PASID, it would just add complexity into
> 
> We don't seem to have an immediate need for PRIVATE_PASID. There are some talks
> about potential usages, but nothing concrete. I think it might be good to
> get rid of it now and add when we really need.
> 
> For SUPERVISOR_MODE, the idea is to have aux domain. Baolu is working on
> something to replace. Certainly the entire kernel address is opening up
> the whole kimono.. so we are looking at dynamically creating mappings on demand.
> It might take some of the benefits of SVA in general with no need to create
> mappings, but for security somebody has to pay the price :-)

My thought is to reuse below aux-domain API.

int iommu_aux_attach_device(struct iommu_domain *domain,
			    struct device *dev)

Currently, it asks the vendor iommu driver to allocate a PASID and bind
the domain with it. We can change it to allow the caller to pass in an
existing supervisor PASID.

int iommu_aux_attach_device(struct iommu_domain *domain,
			    struct device *dev,
			    int *pasid)

In the vendor iommu driver, if (*pasid == INVALID_IOASID), it will
allocate a pasid (the same as current behavior); otherwise, attach
the domain with the pass-in pasid.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
