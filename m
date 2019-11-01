Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180DCA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 17:25:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B0D2085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfCWJlId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B0D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 88BF51054;
	Fri,  1 Nov 2019 17:25:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5BE1C1027
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 17:25:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0ADDD466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 17:25:14 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id BE79C2085B;
	Fri,  1 Nov 2019 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572629113;
	bh=+qlcQrAcofigYmEOrqHZxFLTcNDou11VfkwAvg2V3Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfCWJlIdlWjJkOaipR+OYMfq9mRd+Pba5vzWzfBrBYvpcbu786gFyBDTdgtaIh/lS
	O/3qxiKRWCj9NQr6D076jk0ZtXxj3femZv6c+xfONWDm1lhdSTpUd9UlnAeSyx9KLu
	5+fi8z9iHcNDDixu9oHkqmbG3AjGlzi2w3odoGr8=
Date: Fri, 1 Nov 2019 17:25:08 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Message-ID: <20191101172508.GB3983@willie-the-truck>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, agross@kernel.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	bjorn.andersson@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-msm-owner@vger.kernel.org
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

On Fri, Nov 01, 2019 at 10:49:00PM +0530, Sai Prakash Ranjan wrote:
> On 2019-11-01 22:01, Will Deacon wrote:
> > On Fri, Sep 20, 2019 at 01:34:26PM +0530, Sai Prakash Ranjan wrote:
> > > Previous version of the patches are at [1]:
> > > 
> > > QCOM's implementation of smmu-500 on sdm845 adds a hardware logic
> > > called
> > > wait-for-safe. This logic helps in meeting the invalidation
> > > requirements
> > > from 'real-time clients', such as display and camera. This
> > > wait-for-safe
> > > logic ensures that the invalidations happen after getting an ack
> > > from these
> > > devices.
> > > In this patch-series we are disabling this wait-for-safe logic from
> > > the
> > > arm-smmu driver's probe as with this enabled the hardware tries to
> > > throttle invalidations from 'non-real-time clients', such as USB and
> > > UFS.
> > > 
> > > For detailed information please refer to patch [3/4] in this series.
> > > I have included the device tree patch too in this series for someone
> > > who
> > > would like to test out this. Here's a branch [2] that gets display
> > > on MTP
> > > SDM845 device.
> > > 
> > > This patch series is inspired from downstream work to handle
> > > under-performance
> > > issues on real-time clients on sdm845. In downstream we add separate
> > > page table
> > > ops to handle TLB maintenance and toggle wait-for-safe in tlb_sync
> > > call so that
> > > achieve required performance for display and camera [3, 4].
> > 
> > What's the plan for getting this merged? I'm not happy taking the
> > firmware
> > bits without Andy's ack, but I also think the SMMU changes should go via
> > the IOMMU tree to avoid conflicts.
> > 
> > Andy?
> > 
> 
> Bjorn maintains QCOM stuff now if I am not wrong and he has already reviewed
> the firmware bits. So I'm hoping you could take all these through IOMMU
> tree.

Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
run:

$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c

in linux-next, I get:

Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
linux-kernel@vger.kernel.org (open list)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
