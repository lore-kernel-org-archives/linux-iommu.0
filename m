Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A4110F
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687145829; x=1718681829;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mn9sUNu9bUbT2aZ3NgMLU/44FoDyp8AQtljBXhFRLyg=;
  b=OJI46TMNb8drVGNSKSKqZqznLy4h8c3MvTV3pWciBUw2EAwFGEJw1UdE
   ESLlYrUg0RNpuEfF4NUhIsK+kirMjLw1ppM22i1R7r5fWOl5NerGcHj+j
   RkPBba3ZfDPTh9HctCB4CWPB6ls1CcR4nFNO1xPmWdg+hvyGqLsTuUkB2
   1sh013TSd7AMO+txfS/1WXlHJsn0iKvhDjeIdZDGkQeH5h/hFLiIeMrjy
   OIkI7KyoMtP279Nw0IfPnr2rIb5x5ODJuMKprFjsEvkz/dhh22mG5DGH1
   +eiy82Y35a5UH+U0E/34f6Elpub0MOn4ih4srPrrLCGz/fNlAR8iKfuUH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="445917482"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="445917482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 20:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="858063084"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="858063084"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2023 20:37:04 -0700
Message-ID: <bc963573-f4d3-1467-daaf-2d85f6befe3f@linux.intel.com>
Date: Mon, 19 Jun 2023 11:35:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230616113232.GA84678@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/23 7:32 PM, Jean-Philippe Brucker wrote:
> Hi Baolu,

Hi Jean,

Thank you for the informational reply.

> 
> On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
>> - The timeout value for the pending page fault messages. Ideally we
>>    should determine the timeout value from the device configuration, but
>>    I failed to find any statement in the PCI specification (version 6.x).
>>    A default 100 milliseconds is selected in the implementation, but it
>>    leave the room for grow the code for per-device setting.
> 
> If it helps we had some discussions about this timeout [1]. It's useful to
> print out a warning for debugging, but I don't think completing the fault
> on timeout is correct, we should leave the fault pending. Given that the
> PCI spec does not indicate a timeout, the guest can wait as long as it
> wants to complete the fault (and 100ms may even be reasonable on an
> emulator, who knows how many layers and context switches the fault has to
> go through).

When I was designing this, I was also hesitant about whether to use a
timer. Even worse, I didn't see any description of timeout in the PCI
spec.

I agree with you that a better approach might be to ensure that devices
respect the number of in-flight PPRs that are allocated to them. We need
to design a queue that is large enough to prevent device from flooding
it with page requests.

> 
> Another outstanding issue was what to do for PASID stop. When the guest
> device driver stops using a PASID it issues a PASID stop request to the
> device (a device-specific mechanism). If the device is not using PRI stop
> markers it waits for pending PRs to complete and we're fine. Otherwise it
> sends a stop marker which is flushed to the PRI queue, but does not wait
> for pending PRs.
> 
> Handling stop markers is annoying. If the device issues one, then the PRI
> queue contains stale faults, a stop marker, followed by valid faults for
> the next address space bound to this PASID. The next address space will
> get all the spurious faults because the fault handler doesn't know that
> there is a stop marker coming. Linux is probably alright with spurious
> faults, though maybe not in all cases, and other guests may not support
> them at all.
> 
> We might need to revisit supporting stop markers: request that each device
> driver declares whether their device uses stop markers on unbind() ("This
> mechanism must indicate that a Stop Marker Message will be generated."
> says the spec, but doesn't say if the function always uses one or the
> other mechanism so it's per-unbind). Then we still have to synchronize
> unbind() with the fault handler to deal with the pending stop marker,
> which might have already gone through or be generated later.

I don't quite follow here. Once a PASID is unbound from the device, the
device driver should be free to release the PASID. The PASID could then
be used for any other purpose. The device driver has no idea when the
pending page requests are flushed after unbind(), so it cannot decide
how long should the PASID be delayed for reuse. Therefore, I understand
that a successful return from the unbind() function denotes that all
pending page requests have been flushed and the PASID is viable for
other use.

> 
> Currently we ignore all that and just flush the PRI queue, followed by the
> IOPF queue, to get rid of any stale fault before reassigning the PASID. A
> guest however would also need to first flush the HW PRI queue, but doesn't
> have a direct way to do that. If we want to support guests that don't deal
> with stop markers, the host needs to flush the PRI queue when a PASID is
> detached. I guess on Intel detaching the PASID goes through the host which
> can flush the host queue. On Arm we'll probably need to flush the queue
> when receiving a PASID cache invalidation, which the guest issues after
> clearing a PASID table entry.

The Intel VT-d driver follows below steps to drain pending page requests
when a PASID is unbound from a device.

- Tear down the device's pasid table entry for the stopped pasid.
   This ensures that ATS/PRI will stop putting more page requests for the
   pasid in VT-d PRQ.
- Sync with the PRQ handling thread until all related page requests in
   PRQ have been delivered.
- Flush the iopf queue with iopf_queue_flush_dev().
- Follow the steps defined in VT-d spec section 7.10 to drain all page
   requests and responses between VT-d and the endpoint device.

> 
> Thanks,
> Jean
> 
> [1] https://lore.kernel.org/linux-iommu/20180423153622.GC38106@ostrya.localdomain/
>      Also unregistration, not sure if relevant here
>      https://lore.kernel.org/linux-iommu/20190605154553.0d00ad8d@jacob-builder/
> 

Best regards,
baolu
