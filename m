Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22635C43218
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 01:48:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B5B20652
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 01:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B5B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6A201532;
	Tue, 11 Jun 2019 01:48:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 649751531
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 01:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E253D711
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 01:48:28 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Jun 2019 18:48:27 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 10 Jun 2019 18:48:25 -0700
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
	megaraid_sas
To: Qian Cai <cai@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
	<1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
	<1560174264.6132.65.camel@lca.pw> <1560178459.6132.66.camel@lca.pw>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
Date: Tue, 11 Jun 2019 09:41:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560178459.6132.66.camel@lca.pw>
Content-Type: multipart/mixed; boundary="------------4796EFDAD3CE19C641E50EC9"
Content-Language: en-US
Cc: Joerg Roedel <jroedel@suse.de>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------4796EFDAD3CE19C641E50EC9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Ah, good catch!

The device failed to be attached by a DMA domain. Can you please try the
attached fix patch?

[  101.885468] pci 0000:06:00.0: DMAR: Device is ineligible for IOMMU
domain attach due to platform RMRR requirement.  Contact your platform
vendor.
[  101.900801] pci 0000:06:00.0: Failed to add to iommu group 23: -1

Best regards,
Baolu

On 6/10/19 10:54 PM, Qian Cai wrote:
> On Mon, 2019-06-10 at 09:44 -0400, Qian Cai wrote:
>> On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
>>> Hi Qian,
>>>
>>> I just posted some fix patches. I cc'ed them in your email inbox as
>>> well. Can you please check whether they happen to fix your issue?
>>> If not, do you mind posting more debug messages?
>>
>> Unfortunately, it does not work. Here is the dmesg.
>>
>> https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUM
>> FUQKLW4ZC47ZPIK
> 
> This one should be good to view.
> 
> https://cailca.github.io/files/dmesg.txt
> 

--------------4796EFDAD3CE19C641E50EC9
Content-Type: text/x-patch;
 name="0001-iommu-vt-d-Allow-DMA-domain-attaching-to-rmrr-locked.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-iommu-vt-d-Allow-DMA-domain-attaching-to-rmrr-locked.pa";
 filename*1="tch"

From ff0b1ae0d8fde0655392fde3a1090b03a7a35394 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Tue, 11 Jun 2019 09:29:16 +0800
Subject: [PATCH 1/1] iommu/vt-d: Allow DMA domain attaching to rmrr locked
 device

We don't allow a device to be assigned to user level when it is locked
by any RMRR's. Hence, intel_iommu_attach_device() will return error if
a domain of type IOMMU_DOMAIN_UNMANAGED is about to attach to a device
locked by rmrr. But this doesn't apply to a domain of type other than
IOMMU_DOMAIN_UNMANAGED. This adds a check to fix this.

Fixes: fa954e6831789 ("iommu/vt-d: Delegate the dma domain to upper layer")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1dcb6365ddc4..38232220f6ff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5281,7 +5281,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (device_is_rmrr_locked(dev)) {
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
+	    device_is_rmrr_locked(dev)) {
 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
 		return -EPERM;
 	}
-- 
2.17.1


--------------4796EFDAD3CE19C641E50EC9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------4796EFDAD3CE19C641E50EC9--
