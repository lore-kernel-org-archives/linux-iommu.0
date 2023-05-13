Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346FEDB
	for <iommu@lists.linux.dev>; Sat, 13 May 2023 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683958874; x=1715494874;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kYq/V8AzZkWUq2/ZyfsAahPlzJZsAgoT28ErdCgEvkY=;
  b=BWtvGDSqY5F+V99jbc6MjD6qxiXoUzBbEdNrlQANvE0tH3HTMb5Gv7z6
   lTB+hVOEHfvriiVDLRQ98clQCMMqkPq1wgDCZ0i38HzyC4IVSSfmHqXJM
   c/sKAl7itVtwac5IVy74u6z/nJZqgdEBUanNELdKKtUl1mqPThwmNu3m9
   vexP8+/KC7jCwG1xEcSARbrH0qtZ75+iu1o0GfgGXSrGskJEu/DGnKTFQ
   ggkzmOK6wR2cQD19yp7r9MMTJMmDvOJIFK+GnIXJpgUDggJYxPFYdOiwA
   EXkpm0i1SA64X1R/Cg/GnMG5VFRURDrdf1Y7eYFlBOu44F5VQDcYftn1o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="354070400"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="354070400"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 23:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="946849007"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="946849007"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2023 23:21:12 -0700
Message-ID: <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
Date: Sat, 13 May 2023 14:20:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Content-Language: en-US
To: bugtracker@fischbytes.de, iommu@lists.linux.dev
References: <2282218.ElGaqSPkdT@helios-lx>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2282218.ElGaqSPkdT@helios-lx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote:
> Hi there,
> 
> I came here today to ask if there are any plans regarding the implementation
> of a "relaxed RMRR" kernel parameter to aid using IOMMU on broken platforms
> such as the ProLiant Series by Hewlett Packard Enterprise. To everyone not
> aware of the issue;
> 
> Certain vendors that are under the assumption that standards are for jerks and
> Intel's specifications are a loose optional guideline have implemented RMRR in
> such a way that every PCI device is marked as reserved and therefore cannot be
> passed through to a virtual machine. This issue has been very well documented
> by some people that have a lot more experience than I do at the below linked
> resource. I was hoping that the kernel devs could implement the Relaxed RMRR
> option as an optional kernel parameter to use on these bugged platforms as
> that would re-enable or rather enable a lot of broken servers for the first
> time ever to use PCIe Passthrough. I can verify the issue exists on a HPE
> DL360e Gen8 with trying to passthrough a GPU to a KVM/QEMU machine.
> 
> Link to fix: https://github.com/Aterfax/relax-intel-rmrr
> 
> Furthermore, since I am not a developer and wouldn't claim that I am competent
> enough to decide whether or not implementing this patch would present an issue
> in terms of stability or security, I was hoping that you could evaluate the
> situation. I can verify the pre-built packages for the Proxmox Linux
> environment fix the issue and behave identical in function to other systems
> that ignore RMRR completely, such as VMWare ESXi.
> 
> Thanks alot in advance, you implementing this patch would really mean a lot,
> since the hardware manufacturers just don't seem to care for fixing up this,
> erm, mess.

The relaxed RMRRs are used for legacy purpose, but it requires the full
range of memory addresses are available after the OS device driver takes
over the control of the device.

Not all RMRRs are of this type and typically the VT-d driver only allows
those RMRRs for USB and graphic devices as relaxed ones.

Are you proposing to add a kernel parameter to allow any RMRR for an
arbitrary device to be relaxed, or I didn't get the idea here?

Best regards,
baolu
