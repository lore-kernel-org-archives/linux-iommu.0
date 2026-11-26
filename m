Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659040;
	b=1NX+1ohnL2RnC4pK+1CemHvRRmvrXUTO+mY+mOw6B9OGT2P3cF9s3w3rSl3TmDtnGj29
	 6CE4IsnWR1EY3G/ZcMJMMhK+IwKHqiRYQK8uiWxs/rd2KY61UvFOGVWB27dMYSv4UnZ33
	 2vdAlj0ahV89V8bn3Ti2SwtNkqlK9EN3PfMsaYtCZ+gHuRFLFoy5+CISsqL2VO54nsWI9
	 3qct2tHeKNPYlPNDbq6ue9gBe8MmBPAYqIKkQGC4rvzNqfnXAZURBv8VysBJABfBlp5nb
	 DpeLcHahL6WBleRtvAafp6DmSI2EkO2FDvPLvCHdoQniCULSiz+PYk213VeDz2cBHqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659040;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sfOd+NziBzTa22yAYn3r1uv53slyazXEMhCyhMfSPQo=;
	b=MpxoV2R0zWpEB+L/qUdl0JdewSHxgPm9vrUR5uYiv/ckoil1stwyJyuuqqFfJUeFAJ5B
	 3hR2Z7EwLFt2MlcIsrLQ0vdXO9sL6C6PflyVaCI0/V3NN+1160mRVFsSYJkV80CTqU46A
	 gdoOyL/I8Pf82th10H4yI7H/f/bL6W0TdFAkuz4/n3SBr5aFiDSp1kqxMHfPS3/5+bECH
	 RwFG/6htWzCXMy92GPMeeMEZxF20gp8XcpoEpxGRmFDrEfLD/unqcY/+/nop5SA423iJS
	 5slHpjc+8W7kFPcmWPd9xIA5xtnoznFL5rQV1udIc8lnoR2pQOAHpTzUtgt/h0o1+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uq0Jx+5Y;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C9606A321;
	Thu, 26 Nov 2026 02:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 310C9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uq0Jx+5Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795659039; x=1827195039;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3VD5OE3lHqN+lJeIaePByLYe9hp07+ylRNPf3AKi6T0=;
  b=Uq0Jx+5YEslx0uxdxpjZHn3QQbLDLtyv6VwHtc2Iq//gZYe1CYBsOgCs
   yNVgNHdroU+kQ/LAClC+ZUsYN6TioUdZ8XPJX63IiETLt07+lLLp6Ditl
   JG42Y0DDHHrwtseKLpoP9UM+N6XxytUaGjtIDYjkqa27IQGvudm7SZpnC
   S/TIBrJYiVM/pJdskAMqm4hw8ciF8C8yCRgCKTkp+lyJEl9x5i7Cx0MaZ
   OFMVfvcJcJG29Cd4zzJp13moHUSsLm5zONwjLTkoy+rioiy9DiI7jyu/w
   kjj2FKJpcPwtsNsDHh6l53VC0qsePHcyeX2JEOrNsEwAYXV1zOmrliGeS
   g==;
X-CSE-ConnectionGUID: P07HsrSzR6auGqKXwVEnPQ==
X-CSE-MsgGUID: GV8BftsPR0aC7Z0AnMMjgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4464111"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4464111"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:10:38 -0800
X-CSE-ConnectionGUID: tZeL6rgGT4mSB/WLC+H1sQ==
X-CSE-MsgGUID: PHp++zb5QCeZIucqP1r//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="13814504"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:10:36 -0800
Message-ID: <c1e39b60-c748-488b-ad2b-f94bf71e2441@linux.intel.com>
Date: Thu, 26 Nov 2026 10:10:32 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] iommu/vt-d: Block GCMD and ECMD while acquired by
 the TDX module
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-6-baolu.lu@linux.intel.com>
 <CO1PR11MB4835F23CDAD5127487B5978B8C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835F23CDAD5127487B5978B8C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 11:49 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> Once tdx-host acquires an IOMMU for TDH.IOMMU.SETUP, the TDX module
>> owns its Secure TDX Mode state. The VT-d driver must not change the
>> global state of the IOMMU behind the TDX module's back, nor issue
> 
> just part of the global state, right?

Yes, only the state controlled through GCMD and ECMD interfaces. Once
the IOMMU is in TDX mode, the hardware ignores host writes to GCMD and
ECMD, so the driver would wait for a status update that never comes.

> 
>> enhanced commands, until the IOMMU is released after TDH.IOMMU.CLEAR.
>>
>> Use the tdxc_acquired flag of struct intel_iommu, which is protected
>> by register_lock, to block both. dmar_tdxc_acquire() now fails with
> 
> 'both' means what?

GCMD and ECMD interfaces.

> 
>> -EBUSY if an enhanced command is still in progress when it sets the
>> flag. All GCMD writers hold register_lock and wait for completion before
>> dropping it, so setting the flag under the same lock guarantees no GCMD
>> operation is in flight once acquire() returns. While the flag is set,
>> ecmd_submit_sync() fails with -EBUSY rather than waiting, as it may be
>> called from atomic context.
> 
> this needs a re-write for why GCMD/ECMD are blocked differently.

This is stale. They are actually blocked the same way.

ecmd_submit_sync() also holds register_lock until the command completes,
and IOMMU_WAIT_OP() panics rather than returning on timeout. So no
enhanced command can be in progress once acquire() takes the lock.

The only difference is whether a writer can be reached. GCMD is only
accessed at init, hotplug, suspend and shutdown, so they get
WARN_ON_ONCE(). ECMD can be reached at runtime through perf, which
should be handled specially (see below).

>>
>> Write buffer flushing is the only GCMD write reachable on the runtime
>> map path. Rather than adding a check there, refuse to acquire IOMMUs
>> that require it (rwbf_quirk or CAP.RWBF). Move rwbf_quirk and
>> rwbf_required() to iommu.h so dmar.c can use them.
> 
> good to mention that this quirk is on early old platforms.

Yes. CAP.RWBF is only set on early VT-d hardware. It doesn't apply to a
scalable-mode IOMMU hardware that supports TDX Connect. I am not sure
about a virtualized VT-d. So a WARN_ON check is still needed.

> 
>>
>> The remaining GCMD writers (root table, translation enable/disable,
>> queued invalidation and interrupt remapping) are only used at init,
>> hotplug and suspend/resume. Acquired units are never hot-removed,
>> hibernation is unavailable with TDX, and the following patch refuses
>> system suspend while an IOMMU is acquired. Guard them with
>> WARN_ON_ONCE() ahead of their companion register writes (RTADDR,
>> IQT/IQA, IRTA).
>>
>> intel_iommu_shutdown() is the exception. It is only called from
>> native_machine_shutdown() via machine_shutdown(). On restart, halt,
>> power-off and kexec, syscore_shutdown() runs first and tdx_shutdown()
>> issues TDH.SYS.DISABLE, which takes every IOMMU out of Secure TDX Mode.
>> The crash kexec path doesn't call it. Clear tdxc_acquired there so
>> translation is still turned off.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h         |  8 ++++-
>>   drivers/iommu/intel/dmar.c          | 50 ++++++++++++++++++++++++-----
>>   drivers/iommu/intel/iommu.c         | 33 +++++++++++++++++--
>>   drivers/iommu/intel/irq_remapping.c | 10 ++++++
>>   4 files changed, 89 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 18fef91753a0..26135248675d 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -690,7 +690,10 @@ struct intel_iommu {
>>   	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
>>   	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF
>> */
>>   	raw_spinlock_t	register_lock; /* protect register handling */
>> -	/* Acquired for the TDX module. Protected by register_lock. */
>> +	/*
>> +	 * GCMD and ECMD writes are rejected while the TDX module owns
>> this
>> +	 * IOMMU. Protected by register_lock.
>> +	 */
>>   	bool		tdxc_acquired;
> 
> No need to update this comment. It's still for acquiring the tdx mode.
> 
> explanation of restrictions in the tdx mode belongs to other places.

Agreed.

>   
>> -static void dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool
>> acquired)
>> +static int dmar_tdxc_block_regs(struct intel_iommu *iommu)
> 
> You could keep the original name with comment internally to explain
> the need of blocking certain registers.

Agreed.

> 
>>   {
>> -	guard(raw_spinlock_irqsave)(&iommu->register_lock);
>> -	iommu->tdxc_acquired = acquired;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>> +	if (cap_ecmds(iommu->cap) &&
>> +	    (readq(iommu->reg + DMAR_ECRSP_REG) &
>> DMA_ECMD_ECRSP_IP))
>> +		ret = -EBUSY;
> 
> here a comment is appreciated, for both why a check on ecmd is required
> but not for gcmd.

Will fix this.

> 
>> @@ -2669,11 +2695,19 @@ int dmar_tdxc_acquire(struct pci_dev *pdev,
>>   	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi
>> || !sm_supported(iommu))
>>   		return -EINVAL;
>>
>> +	/* Write buffer flushing needs GCMD, which is blocked once acquired.
>> */
>> +	if (rwbf_required(iommu))
>> +		return -EOPNOTSUPP;
>> +
> 
> let's be clear here that WBF is incompatible with tdx mode. It's an old
> quirk hence simply rejecting it if required.

Yes, sure.

> 
>> @@ -4336,6 +4353,16 @@ int ecmd_submit_sync(struct intel_iommu
>> *iommu, u8 ecmd, u64 oa, u64 ob)
>>
>>   	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>>
>> +	/*
>> +	 * The TDX module owns this IOMMU. This may be called from
> 
> the TDX module doesn't own the entire IOMMU

Will fix this.

> 
>> atomic
>> +	 * context (e.g. perf pmu::start/stop), so don't sleep; just reject
>> +	 * the request.
>> +	 */
>> +	if (iommu->tdxc_acquired) {
>> +		ret = -EBUSY;
>> +		goto err;
>> +	}
>> +
> 
> iommu_pmu_stop() doesn't check the return value of this. It's a void
> function. So returning error here still breaks the perf feature.
> 
> we may need a way to disable iommu perf completely in the acquire
> function.

Good catch. Returning an error there leaves events that look like
they're running but never count, or that can't be stopped.

I'll make perf events and TDX mode mutually exclusive instead:

- The iommu pmu counts its live events under register_lock.
- event_init() fails with -EBUSY while the IOMMU is acquired.
- acquire() fails with -EBUSY while any event exists.

Something like the following(compiled but not tested). Does this work
for you?

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1bbfb1b6f905..0945e63c901a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -674,6 +674,7 @@ struct iommu_pmu {
  	struct pmu		pmu;
  	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
  	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
+	unsigned int		nr_events;	/* Protected by iommu->register_lock */
  	unsigned char		irq_name[16];
  };

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f0ac8c433198..1ae27198b999 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2588,10 +2588,15 @@ static void dmar_tdxc_unreserve_did(struct 
intel_iommu *iommu)
  }

  /* GCMD and ECMD writers complete under register_lock, so none is in 
flight. */
-static void dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool 
acquired)
+static int dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool acquired)
  {
  	guard(raw_spinlock_irqsave)(&iommu->register_lock);
+	/* Perf issues enhanced commands at runtime and can't handle failure. */
+	if (acquired && iommu->pmu && iommu->pmu->nr_events)
+		return -EBUSY;
+
  	iommu->tdx_acquired = acquired;
+	return 0;
  }

  static struct dmar_drhd_unit *dmar_tdxc_find_drhd(struct pci_dev *pdev)
@@ -2677,9 +2682,11 @@ int dmar_tdx_acquire(struct pci_dev *pdev)
  	if (ret)
  		return ret;

-	dmar_tdxc_set_acquired(iommu, true);
+	ret = dmar_tdxc_set_acquired(iommu, true);
+	if (ret)
+		dmar_tdxc_unreserve_did(iommu);

-	return 0;
+	return ret;
  }
  EXPORT_SYMBOL_FOR_MODULES(dmar_tdx_acquire, "tdx-host");

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6dbb421d8099..c810b4776fd7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4358,12 +4358,8 @@ int ecmd_submit_sync(struct intel_iommu *iommu, 
u8 ecmd, u64 oa, u64 ob)

  	raw_spin_lock_irqsave(&iommu->register_lock, flags);

-	/*
-	 * The TDX module owns this IOMMU. This may be called from atomic
-	 * context (e.g. perf pmu::start/stop), so don't sleep; just reject
-	 * the request.
-	 */
-	if (iommu->tdx_acquired) {
+	/* Perf, the only caller, is kept off IOMMUs acquired for TDX mode. */
+	if (WARN_ON_ONCE(iommu->tdx_acquired)) {
  		ret = -EBUSY;
  		goto err;
  	}
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index e40ed253eaa9..e4df1aee4fcd 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -276,9 +276,19 @@ static int iommu_pmu_validate_group(struct 
perf_event *event)
  	return 0;
  }

+static void iommu_pmu_event_destroy(struct perf_event *event)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+
+	guard(raw_spinlock_irqsave)(&iommu_pmu->iommu->register_lock);
+	iommu_pmu->nr_events--;
+}
+
  static int iommu_pmu_event_init(struct perf_event *event)
  {
  	struct hw_perf_event *hwc = &event->hw;
+	struct iommu_pmu *iommu_pmu;
+	int ret;

  	if (event->attr.type != event->pmu->type)
  		return -ENOENT;
@@ -295,7 +305,20 @@ static int iommu_pmu_event_init(struct perf_event 
*event)

  	hwc->config = iommu_event_config(event);

-	return iommu_pmu_validate_group(event);
+	ret = iommu_pmu_validate_group(event);
+	if (ret)
+		return ret;
+
+	iommu_pmu = iommu_event_to_pmu(event);
+	guard(raw_spinlock_irqsave)(&iommu_pmu->iommu->register_lock);
+	/* The enhanced commands that perf relies on are blocked in TDX mode. */
+	if (iommu_pmu->iommu->tdx_acquired)
+		return -EBUSY;
+
+	iommu_pmu->nr_events++;
+	event->destroy = iommu_pmu_event_destroy;
+
+	return 0;
  }

  static void iommu_pmu_event_update(struct perf_event *event)
-- 
2.53.0

Thanks,
baolu
