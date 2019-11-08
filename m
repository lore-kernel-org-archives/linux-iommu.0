Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C23FA372C
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4B9206A3
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSZsLCIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B9206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 764F7DDC;
	Fri,  8 Nov 2019 17:48:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97A86D80
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 17:48:51 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 434E98AE
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 17:48:51 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A98A920673;
	Fri,  8 Nov 2019 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235331;
	bh=GE9PFeLXesIuv0zEy2ffSpiHpDpB3tEJiSldwNibaS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSZsLCIscNKdexiVYE6cN58MOHJ17AuEt3qEIS+AD8PSgv6IX4c+q9ZASqv4F4l3m
	CKFysVQakrkZdtSGp2zOn7tGmKy9BYdUqPA213MDrjVFD02gjk64+S4FbAyk+qV7gm
	Sdagw9Xh2NOWKREY3IilhnUb6L1KHT9yyu02L+xs=
Date: Fri, 8 Nov 2019 17:48:46 +0000
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
	explicitly non-modular"
Message-ID: <20191108174846.GA22677@willie-the-truck>
References: <20191108151608.20932-1-will@kernel.org>
	<20191108151608.20932-7-will@kernel.org>
	<06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
	<7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
	<20191108164728.GB20866@willie-the-truck>
	<c4cb13d3-3786-2e45-ba57-9965cead9a49@huawei.com>
	<20191108173248.GA22448@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191108173248.GA22448@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Nov 08, 2019 at 05:32:48PM +0000, Will Deacon wrote:
> On Fri, Nov 08, 2019 at 05:25:09PM +0000, John Garry wrote:
> > On 08/11/2019 16:47, Will Deacon wrote:
> > > On Fri, Nov 08, 2019 at 04:44:25PM +0000, John Garry wrote:
> > > > BTW, it now looks like it was your v1 series I was testing there, on your
> > > > branch iommu/module. It would be helpful to update for ease of testing.
> > > 
> > > Yes, sorry about that. I'll update it now (although I'm not sure it will
> > > help with this -- I was going to see what happens with other devices such
> > > as the intel-iommu or storage controllers)
> > 
> > So I tried your v2 series for this - it has the same issue, as I
> > anticipated.
> 
> Right, I'm just not sure how resilient drivers are expected to be to force
> unbinding like this. You can break lots of stuff with root...
> 
> > It seems that some iommu drivers do call iommu_device_register(), so maybe a
> > decent reference. Or simply stop the driver being unbound.
> 
> I'm not sure what you mean about iommu_device_register() (we call that
> already), but I guess we can keep the '.suppress_bind_attrs = true' if
> necessary. I'll have a play on my laptop and see how well that works if
> you start unbinding stuff.

So unbinding the nvme driver goes bang:

[90139.090158] nvme nvme0: failed to set APST feature (-19)
[90141.966780] Aborting journal on device dm-1-8.
[90141.967124] Buffer I/O error on dev dm-1, logical block 26247168, lost sync page write
[90141.967169] JBD2: Error -5 detected when updating journal superblock for dm-1-8.
[90141.967403] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
[90141.967454] EXT4-fs (dm-1): I/O error while writing superblock
[90141.967467] EXT4-fs error (device dm-1): ext4_journal_check_start:61: Detected aborted journal
[90141.967473] EXT4-fs (dm-1): Remounting filesystem read-only
[90141.967569] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
[90141.967682] EXT4-fs (dm-1): I/O error while writing superblock

and I've not managed to recover the thing yet (it's stuck trying to reboot.)

What state was your system in after unbinding the SMMU?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
