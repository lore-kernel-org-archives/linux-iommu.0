Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA93081A2
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672958; cv=none; b=gFKAk1LjGbRAGhP4+SH1i+HTgqMIBfjTjS8PfUzHwpP6X0DIAS4kigTexQe/2xmV/YX5oXai7mmTYeQVA+KgrpQnhX6HXNQMfGszMb9fP5s2ONi0SIay2UHt2/lonC9JHX+fUex9lmfJkWfNfctikyufyFoidLf7UB81rqSm1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672958; c=relaxed/simple;
	bh=kK/HTSk/iQa8kvx+w4WgfImH3lwwRkYPZ8LNkvUssbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXhdlOvWISV7+5l6mIshG+ZbWpNAwPQRnybM3TkMvt3U2ZyEriCwzGTOEL+ioyYwHjbB4ItdyxIHUBfvk+zHNdTswMnttj5xqfGfLO9J+7PCO0xlU2uXXbgU/BXPxxQqaoKZAdMxnl81wdmiNMPQwSSajZ7h3coEd1YhV2y8xAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ECB6C4C4430024;
	Mon, 16 Mar 2026 15:54:33 +0100 (CET)
Message-ID: <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
Date: Mon, 16 Mar 2026 15:54:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Baolu, dear Linux folks,


Thank you for looking into this.

Am 27.02.26 um 03:23 schrieb Baolu Lu:
> On 2/8/26 03:10, Paul Menzel wrote:

>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error 
>> below:
>>
>>      [17959.189315] ACPI: EC: event unblocked
>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>
>> 3c:00.0 is the NVMe controller/device.
>>
>>      $ lspci -nn -s 3c:00.0
>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid State Drive 512GB [1c5c:1284]
>>
>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>
>> To my knowledge, this is *not* a new problem. Please find the log 
>> messages attached. (Ignore the other DMAR error for now.)
> 
> These IOMMU DMA faults are triggered when the NVMe controller attempts
> DMA writes to system memory address 0x0. The IOMMU hardware blocked
> these accesses because the system software has not granted the device
> permission to write to this specific address. It's unlikely a bug or
> problem in the iommu driver as far as I can see.
I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe controller:

     $ lspci -nn -s 3d:00.0
     3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)

Logs from Debian’s Linux 6.19.8:

     [  726.138732] DMAR: DRHD: handling fault status reg 3
     [  726.138736] DMAR: [DMA Read NO_PASID] Request device [3d:00.0] 
fault addr 0xffffd000 [fault reason 0x06] PTE Read access is not set
     [  726.141470] nvme nvme0: 12/0/0 default/read/poll queue

It’d be great if this could be fixed.


Kind regards,

paul
