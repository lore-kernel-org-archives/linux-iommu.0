Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50A15531A;
	Mon,  5 Aug 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861007; cv=none; b=XYu7eHLYSyzHmEFf486ugCiV/C0OMQSTz2CDkNb6B1NQwQ9zaUdmbyZkUiLkz/qFSo4esB0tNEXPafXwj2J3TdxM3y5dwzsElg4WU6um1W+tpgMzn5RUEozPsFJgC80Fa86IHJcwyAjxIezaPwA72QgSrnhM3EG8iCa3ClmaZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861007; c=relaxed/simple;
	bh=elZbngq80SUY1S3qBAQCd1SsC7QqkMJLPB2fKd2rP1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN3Y73QT0wQ5oKRx4Fgyquip3ulwbA1XLTSAGIypZjSyO2bve7Gigd0g6/voEcXkj49LpNu7dVEX/dzTOcYXNvdHh9qhMNMMZ9vvfCk/xzz4xZ6iB0RfdwgMYM6XEZJZuh1Lg3AGuPJqQWKwWRgItQvvP5HFC7kvDeQ45L+zeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu8Rh+mp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu8Rh+mp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7913C32782;
	Mon,  5 Aug 2024 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722861007;
	bh=elZbngq80SUY1S3qBAQCd1SsC7QqkMJLPB2fKd2rP1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu8Rh+mpECotmzB+sQW7BeeL1BjpeXrPRn/N6K3D8QJz2EsW7U6pTY3co0HnjLMu6
	 OmJaQtDms77FX8E3GL/OmwTVZsFNLRdEwNZnbjfzOt1cXf9BQ2zZ3H4zRVO5HjN923
	 svkYMTmcPUGRg9EgAL19WbPBVYDW1nLE0WvCDKyo9gg6zNF80crQWntAue5y3sNJDU
	 t3ztAfE/n9NK08I0cTiNhdojlrShYSwJzComVYW2KcYs1wdJaCx82VtQVL+RkeWV1a
	 Xxa/HShUPwxgahAW0FkIxmd4ur9jnt4+1RBYYKc18ykR3NyFd3BL9Tx+pll00UItHe
	 OFdJ+LxI0EeEg==
Date: Mon, 5 Aug 2024 13:30:01 +0100
From: Will Deacon <will@kernel.org>
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240805123001.GB9326@willie-the-truck>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 05, 2024 at 08:13:09PM +0800, Kunkun Jiang wrote:
> On 2024/8/2 22:38, Pranjal Shrivastava wrote:
> > Hey,
> > On Mon, Jul 29, 2024 at 11:02 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > On 2024/7/24 18:24, Will Deacon wrote:
> > > > On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
> > > > > On 2024/7/24 9:42, Kunkun Jiang wrote:
> > > > > > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > > 1797                 while (!queue_remove_raw(q, evt)) {
> > > > > > 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > > > > 1799
> > > > > > 1800                         ret = arm_smmu_handle_evt(smmu, evt);
> > > > > > 1801                         if (!ret || !__ratelimit(&rs))
> > > > > > 1802                                 continue;
> > > > > > 1803
> > > > > > 1804                         dev_info(smmu->dev, "event 0x%02x
> > > > > > received:\n", id);
> > > > > > 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > > > > > 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
> > > > > > 1807                                          (unsigned long
> > > > > > long)evt[i]);
> > > > > > 1808
> > > > > > 1809                         cond_resched();
> > > > > > 1810                 }
> > > > > > 
> > > > > > The smmu-v3 driver cannot print event information when "ret" is 0.
> > > > > > Unfortunately due to commit 3dfa64aecbaf
> > > > > > ("iommu: Make iommu_report_device_fault() return void"), the default
> > > > > > return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> > > > > > be added here?
> > > > > Additional explanation. Background introduction:
> > > > > 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
> > > > > 2.The SMMU has the stall feature.
> > > > > 3.Modified guest device driver to generate an event.
> > > > > 
> > > > > This event handling process is as follows:
> > > > > arm_smmu_evtq_thread
> > > > >       ret = arm_smmu_handle_evt
> > > > >           iommu_report_device_fault
> > > > >               iopf_param = iopf_get_dev_fault_param(dev);
> > > > >               // iopf is not enabled.
> > > > > // No RESUME will be sent!
> > > > >               if (WARN_ON(!iopf_param))
> > > > >                   return;
> > > > >       if (!ret || !__ratelimit(&rs))
> > > > >           continue;
> > > > > 
> > > > > In this scenario, the io page-fault capability is not enabled.
> > > > > There are two problems here:
> > > > > 1. The event information is not printed.
> > > > > 2. The entire device(PF level) is stalled,not just the current
> > > > > VF. This affects other normal VFs.
> > > > Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
> > > > iopf_group_response() return void"). I agree that we need a way to
> > > > propagate error handling back to the driver in the case that
> > > > 'iopf_param' is NULL, otherwise we're making the unexpected fault
> > > > considerably more problematic than it needs to be.
> > > > 
> > > > Lu -- can we add the -ENODEV return back in the case that
> > > > iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
> > > > the device?
> > > Yes, of course. The commit b554e396e51c was added to consolidate the
> > > drivers' auto response code in the core with the assumption that driver
> > > only needs to call iommu_report_device_fault() for reporting an iopf.
> > > 
> > I had a go at taking Jason's diff and implementing the suggestions in
> > this thread.
> > Kunkun -- please can you see if this fixes the problem for you?
> Okay, I'll test it as soon as I can.

It looks like the diff sent by Pranjal has whitespace mangling, so I
don't think you'll be able to apply it.

Pranjal -- please can you send an unmangled version? If you want to test
out your mail setup, I'm happy to be a guinea pig so you don't spam the
mailing lists!

Cheers,

Will
