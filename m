Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FD1D7E5B
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480001; cv=none; b=tsOX6kKNRp43gS6c+DHalZA3juNekQY4zTjljPpNf2uOi7MjhCwaRDRkvx1rJpT2YsPUHoqeozUL7tIfgGPBtxVFE1Kw7MmMMoA1T0G/0V81VRnIkchg3Jn1iEXGvIHpTk5ZjWRRyEr/MoauqL2JbGjMI6r2B/QOWtwI5BgFHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480001; c=relaxed/simple;
	bh=FWq5q6DibBDxfl9XwXgzcY/LP7UroVSeqWq/C7KWOUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXmc42OXkkpif6z9sHmwnwRFcg5N2OJl6j1J9WVtuJEs9he+fFCVa/dyVp4lLaKYejqLObv0Dj1ga0wSJLYnG31nk7y2oiJjqUBYtPF6R/baXKaCZyXTs/r0urRerESW9jIa9o2arsX+ZuEuQAPLLcjHHNOlGZ89pAG5q57kC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZP6XSk8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZP6XSk8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2263428c8baso163835ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742479998; x=1743084798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oh5DCpJXy6fW9B9CEFLvimWKH0r/+53WovJCy+Q/mUQ=;
        b=kZP6XSk81gAThd909uKuCl+vJkaprF2DeNKsjcAhnRz4+pPXSSWPuO2iYq6XKqtFF1
         9wMc+BnCFb4EeEl2tngpHbyxD/VHob5AzvZqVRSzR7jxX/LOChgISsJ/m8nrQHTFvx/c
         OgM2cushf5OcAVXrd9BD/2XX6lN8pSKVoA0wUhVdZmYMBIdPnCmR+TaSUx0Ve1ampmwP
         uPoWJR/kA375oXGsJspNl5W+yAr5mRWRSEe2suu4JaVPiD/pKrwl3z3YeO4E8FglvOWr
         ae8QfgRigP4YUPc4i6j4vSX61cwGQJR8eocxgSqgx6wQPxVg75jTDk2oc3zYA5pWToA8
         B8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479998; x=1743084798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh5DCpJXy6fW9B9CEFLvimWKH0r/+53WovJCy+Q/mUQ=;
        b=g5HeyBggq0A1O98ySj9xNrBoeh+MmqP6m2iZrnlk1sqY3JKQyf4ks/8/8eumNCPfHY
         m07+3YHijw/sAgivgXQFSWm4pid43CerPJvYry1A+Pc+mgejIyXD5zD7UvpqH3OhVSD6
         xP7qBqzz6YJCywO7/aZa+6gD1vsDk1KDtUTClx2l8iLxQP6QgimhNm6R6G3kUrQJ87Je
         hQbtIBmGUkcYJdxINku8LcCBMXQQdM1PgASz9o/GoJ1/MMV9we+Pi0sixHwbM0vdYhlf
         dZ4MHOiU+BxXCcpXp/C2+TH65cUZXMgALlXjjetsOE+y760KcJqrfMUHX2yOl2YeCXU2
         wTnA==
X-Forwarded-Encrypted: i=1; AJvYcCUgTXMI/1sEgVlBDhZgA0bN4kUcpDDr/ODzU0frVjcUlOTEweNzjDt3TTlHj/2AsijVkZ61cA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Bg0hYEiLrIg5VYFWhtxKa4V0iXpMvaMKCjThAmQqBQve0ytx
	k+GCzYvWOLu/QvgkKjPNpC5XY9CANY0NKglNr6tkorocWXE9O3GLPJtqd9E+uA==
X-Gm-Gg: ASbGncuvz1eVGahpIJ+vUk8j8C3nXpIt55KW3smvwB1j9QHQKdLHeQWM6Ugt17udC5s
	n/3scl0h7Mckt+GS1Bqc3soEft4+OaZVL/7zJy4dcALxRiPDw+6Op9Padl37JYzb6zH18s0kpg0
	i71N8D537aTwYVU2ZV8kyyJvm++bM4T7ESOfC1gu8K/4OIo7SmpEtV4zEruP7PS1siB3DTjdDvH
	c9jjoRSuI404Gg3t5x+dtMWX95kOQ9+00xQ5hPZcowE7ekWumBV5pvJQfe7R9WkYCkzgwkTwDZX
	3DpXJDR0fNXfDIvFaX0JSRjLitGsvbjP/vNi3gl4vgAPKodnj6K2rZexIAN6b48YhOreYsoYClB
	VxwY=
X-Google-Smtp-Source: AGHT+IFtY5Zj1QbdOf+JRmGyrwe/Z6HdICoxUJhPehE0wANxFI/NknLoWIQ6614rqCIHAUSTozx8Jw==
X-Received: by 2002:a17:902:e74c:b0:212:26e:1b46 with SMTP id d9443c01a7336-22661fe5b85mr2444055ad.23.1742479997202;
        Thu, 20 Mar 2025 07:13:17 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5d97sm135465775ad.259.2025.03.20.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:13:16 -0700 (PDT)
Date: Thu, 20 Mar 2025 14:13:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z9widNEXgJdfQd-G@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>

On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> On 19/03/2025 12:42 am, Pranjal Shrivastava wrote:
> > As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
> > devices, power management capabilities, similar to its predecessors, are
> > crucial for these applications. This series introduces power management
> > support for the arm-smmu-v3 driver.
> > 
> > Design
> > =======
> > The arm-smmu-v3 primarily operates with in-memory data structures
> > through HW registers pointing to these data structures in some fashion.
> > The proposed design tries to make use of this fact for implementing the
> > suspend and resume ops.
> > 
> > 1. Suspend / Resume
> > An initial idea for the "suspend" op is to wait till the command queue
> > finishes all commands before disabling the SMMU through CR0. In order to
> > avoid mis-use / spurious transactions (b/w SMMU disable -> power-down),
> > the GBPA register is configured to abort all transactions.
> 
> But why disable SMMUEN at all? We can't expect the SMMU to come back in the
> same configuration we left it anyway (*including* GBPA, note), so what's the
> benefit of spending time and effort to potentially change its behaviour for
> a handful of microseconds before it all goes dark anyway?

Just for thwarting any potential security issues, since the clients
*may* be running their own firmware (something like a GPU maybe?) and in
case __that__ firmware is compromised, windows like this could
potentially be a way to inject an attack vector into the RAM.

Since, GBPA.Abort bit resets to an "IMPLEMENTATION DEFINED" value, there
might be implementations that take care of setting the ABORT bit with
Power-ON Reset.

I may be thinking too much here, let me know if this needs to be dropped?

> 
> Draining the command queue shouldn't strictly be necessary it only contains
> invalidations and syncs, since we know all the cached state they could refer
> to is going to be thrown away by the time the SMMU has come back anyway. If

More than just SMMU's TLBIs, I think we'd still need the ATC
invalidations to go through, right? As the ATC is present in the PCIE_EP
and if a translation is cached in the ATC, AFAIK, the EP gets to bypass
the SMMU, which could potentially lead to mis-translations...

> anything, making sure there are no outstanding IOPF handlers and the event
> queue and PRI queue are clear (as expected) seems more important, because
> the potential to lose hardware tokens or leave a stalled transaction across
> the interconnect would be A Bad Thing.

Right, agreed. I'll drain the eventq and priq in the next version.
But I think we'll still need to drain the CMDQ, since there might be a
RESUME_OP or PRI_RESP pending to be consumed? Or are you suggesting no
client driver would drop a ref if a transaction is stalled?

Also, we'd need to maintain the prod / cons for all the queues, since
the arm_smmu_device_reset will re-init the HW regs from values stored in
llq->prod/cons, if those values aren't same, it may trigger consumption.

> 
> > The resume operation uses the `arm_smmu_device_reset` function which
> > re-initializes the HW using the SW-copies maintained by the driver. For
> > example, prod/cons for queues, base addresses for queues & tables. The
> > arm_smmu_device_reset also clears the TLBs.
> > 
> > 2. Interrupt Re-config
> > a. Wired irqs: the series refactors the `arm_smmu_setup_irqs` to be
> > able to enable/disable irqs and install their handlers separately to
> > help with the re-initialization of the interrupts correctly.
> > 
> > b. MSIs: The thought was of 2 approaches to teardown & re-config MSIs:
> > 
> >   1. Free MSIs on suspend and re-alloc on resume (implemented in series)
> >   2. Meddle with the msi_desc and use get_cached_msi_msg to resume MSIs.
> 
> 3: Just explicitly save/restore the IRQ_CFG{0,1} registers in the PM
> callbacks.
> 4: Have arm_smmu_write_msi_msg() stash the values, and defer the actual
> IRQ_CFG register writes until arm_smmu_setup_irqs(), alongside IRQ_CTRL.
> 
> If the other options aren't sufficiently clean or straightforward, another
> 36 bytes per arm_smmu_device instance isn't the end of the world...
> 

Ack. I had thought of something like desc->msg = *msg; in
arm_smmu_write_msi_msg, and then get_cached_msi_msg() in resume but it
felt hacky.. If we have consensus, then I'd like to use option 4. and
maybe cache the data in the arm_smmu_write_msi_msg() itself. Something
like:

irq_chip_write_msi_msg() 
  -> platform_msi_write_msi_msg
    -> arm_smmu_write_msi_msg()
      (desc->msg = *msg;)

then get_cached_msi_msg -> call arm_smmu_write_msi_msg in resume cb.
(cooked up a diff and attached at the end).

> > The first approach (implemented in this series) may be potentially
> > slower, whereas the second one could reduce the time taken to resume.
> > However, the second one feels hacky as it forces us to cache the msi_msg
> > in `arm_smmu_write_msg` or in the core code (`irq_chip_write_msi_msg`)
> > as suggested in [1].
> > 3. Invoking runtime_pm_get/put
> > Given that most of the configuration done by arm-smmu-v3 is stored in
> > memory, the initial idea is to focus on areas where the driver accesses
> > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > 
> > Instead of wrapping every exposed op with an rpm_get/put, the idea is to
> > follow through till a logical common point (lowest common ancestor in
> > the call hierarchies) and wrap those with the rpm_get/put calls.
> 
> As mentioned already, I think there should be very few, if any, places where
> we actually need an rpm_get() to explicitly resume a suspended SMMU. All the
> initial hardware probing and reset can (and should) be done before PM is
> enabled; IRQ handlers can reasonably assume that any call while the SMMU is
> suspended must be shared or spurious, so don't need to look (even more so if
> we do still clear IRQ_CTRL on suspend); any commands issued while suspended
> are either safe to ignore (CFGI/TLBI/PREFETCH) or nonsensical

Ack. I think we can convert all IRQ handlers to use rpm_get_if_active
because there's a chance where we get an event, the threaded_irq is
scheduled and before it's executed to completion all the refs are
dropped and the SMMU is powered off.

Regarding TLBI/CFGI/Prefetch, I agree that it makes sense to go ahead
with them only if the SMMU is powered ON, otherwise elide everything.

> (RESUME/PRI_RESP) - the only one I'm not entirely sure about off the top of
> my head is ATC_INV, which might depend on whether the PCI code can guarantee
> that an endpoint will resume with a clean ATC.
> 

Exactly, and are we sure that the EP will be *really* suspended with the
SMMU? Even if the kernel assumes that a PCIe EP is down, it may still be
partially active or not even have a *real* ATC but just a firmware
implementation... for such cases, I believe we should explicitly wake up
for ATC invalidations atleast.

> I don't see SVA and VFIO needing any special considerations, so it might
> just be the new vIOMMU stuff which may need to hold PM enabled for the
> lifetime of things exposed to userspace.
> 

Hmm..so maybe just hold a ref till it's destroyed? 

Thanks,
Praan

==============================================================================
The proposed MSI diff:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f8d74ccaed6a..58eb8af289fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4020,6 +4020,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Save the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -4028,6 +4031,38 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	if (!smmu->dev->msi.domain)
+		return;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->gerr_irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
+		if (desc) {
+			get_cached_msi_msg(smmu->priq.q.irq, &msg);
+			arm_smmu_write_msi_msg(desc, &msg);
+		}
+	}
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
@@ -5018,6 +5053,7 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
 	dev_dbg(dev, "Resuming device\n");
+	arm_smmu_resume_msis(smmu);
 
 	/*
 	 * The reset will re-initialize all the queues with the base addr,

