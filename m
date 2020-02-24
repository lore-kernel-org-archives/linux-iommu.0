Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1065BC11D2F
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:22:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E390720838
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E390720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2DD28517C;
	Mon, 24 Feb 2020 18:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c92y9JQpy9Bu; Mon, 24 Feb 2020 18:22:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0AABD84B8F;
	Mon, 24 Feb 2020 18:22:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6D44C18DA;
	Mon, 24 Feb 2020 18:22:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF3F8C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AAFF420500
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWyY5FyrVnwq for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 18E0520414
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:22:04 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 10:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="284426587"
Received: from araj-mobl1.jf.intel.com ([10.24.11.16])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 10:22:02 -0800
Date: Mon, 24 Feb 2020 10:22:02 -0800
From: "Raj, Ashok" <ashok.raj@linux.intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
Message-ID: <20200224182201.GA22668@araj-mobl1.jf.intel.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

Hi Kenneth,

sorry for waking up late on this patchset.


On Wed, Jan 15, 2020 at 10:12:46PM +0800, Zhangfei Gao wrote:
[... trimmed]

> +
> +static int uacce_fops_open(struct inode *inode, struct file *filep)
> +{
> +	struct uacce_mm *uacce_mm = NULL;
> +	struct uacce_device *uacce;
> +	struct uacce_queue *q;
> +	int ret = 0;
> +
> +	uacce = xa_load(&uacce_xa, iminor(inode));
> +	if (!uacce)
> +		return -ENODEV;
> +
> +	q = kzalloc(sizeof(struct uacce_queue), GFP_KERNEL);
> +	if (!q)
> +		return -ENOMEM;
> +
> +	mutex_lock(&uacce->mm_lock);
> +	uacce_mm = uacce_mm_get(uacce, q, current->mm);

I think having this at open time is a bit unnatural. Since when a process
does fork, we do not inherit the PASID. Although it inherits the fd
but cannot use the mmaped address in the child.

If you move this to the mmap time, its more natural. The child could
do a mmap() get a new PASID + mmio space to work with the hardware.


> +	mutex_unlock(&uacce->mm_lock);
> +	if (!uacce_mm) {
> +		ret = -ENOMEM;
> +		goto out_with_mem;
> +	}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
