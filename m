Return-Path: <SRS0=4AON=WJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEEC32750
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 17:10:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1022A20840
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 17:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSoIwMBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1022A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DCA2BDC2;
	Tue, 13 Aug 2019 17:10:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ED397D8B
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 17:10:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 956048A3
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 17:10:44 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CCE5E20679;
	Tue, 13 Aug 2019 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565716244;
	bh=3HAujAOVhRvVLw9Wr49q0ihG1ZR2YhR/IpIuwrI01jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSoIwMBNPftQwtRHK78noD6VrYTtEw2/zdtVMnZa+W21+JNwBjt4M/+CUmJoAKYgm
	vxnL6pOXtRJd3CWe1kfjMMNi8OVv8A4+2H2XXoExvno/NOG8KwCkt3EU/SRc/RJnOy
	8Wu9Xp1qau4NNWdG7KQeXOPxv1afsB4fLI53LFeo=
Date: Tue, 13 Aug 2019 18:10:40 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add nr_ats_masters to avoid
	unnecessary operations
Message-ID: <20190813171039.y64wslo4dzgyis3e@willie-the-truck>
References: <20190801122040.26024-1-thunder.leizhen@huawei.com>
	<b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: jean-philippe@linaro.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Aug 12, 2019 at 11:42:17AM +0100, John Garry wrote:
> On 01/08/2019 13:20, Zhen Lei wrote:
> > When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
> > smmu domain does not contain any ats master, the operations of
> > arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
> > are always executed. This will impact performance, especially in
> > multi-core and stress scenarios. For my FIO test scenario, about 8%
> > performance reduced.
> > 
> > In fact, we can use a atomic member to record how many ats masters the
> > smmu contains. And check that without traverse the list and check all
> > masters one by one in the lock protection.
> > 
> 
> Hi Will, Robin, Jean-Philippe,
> 
> Can you kindly check this issue? We have seen a signifigant performance
> regression here.

Sorry, John: Robin and Jean-Philippe are off at the moment and I've been
swamped dealing with the arm64 queue. I'll try to get to this tomorrow.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
