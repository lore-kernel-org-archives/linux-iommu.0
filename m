Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA923DEAE3
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870749; cv=none; b=O+r8fJCgxhC9FfOe36gRJJRgM2VdEOGDCifNkuu+Otv5TB3jmbUygmi5rsdyCHMeiXd34pSEgCBpWWZaXO26GAcdhiE7TeTuhnuB/nGhxbFkfcwS+IRRK3HMrtklnCnszxN7HlBGWeIAGmZ7kz+GtHbi/hn7znxdtefTyB7q/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870749; c=relaxed/simple;
	bh=cwHIjHAe8KJf/GMsGK3Swi8r1zcSw/mau5aBaAmzT30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCjxJIPRv68sB3321UpFgqzWQ1qUoLSlk17I8BEF+9tPH6yooJu3kEy2riv7O2m0Dmm2ZTiuCirIwcGSvNupU+W6DovLOUKSMvhDEIELt/7B58r6oDJYAsH+AY6CiN8menfEHx7tHHTHW69Nr2Nm/VjneTQtP5eL1WOtrzVqJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKycEHQY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKycEHQY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ed9336049so1164338f8f.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870746; x=1780475546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dy1tdo3WsNXJ1hXO7TcI9ffqFZPej1pmbFWn2tPCdc=;
        b=OKycEHQYkSkggcR5p2govBL2KZ1la6awHidp2bJX2gbxPOq6yOzIw8IF8H0d6NZh7k
         s7YRVO5Yt0spiIfafbiMOaQL1wUigiUuEJni//+v2OrjlJobVwm8DSgPYM0l0QmIl3C1
         dID7tQGL6bBk2gXE0ix2wpDrhUXqh32jBVS65my5CtvI5Vegtv22Cg3IHIpx2ZJeU/Za
         WPtgvefFY81DFgSVst+1ogcJDd+SI+hJzOzCuA5tqj9sS/NmhgM9N8Idcfz5HqrkEMhQ
         /bEsHw0vi+wNV9y+sNQXZaQ6BY2xsEDCe2UfCmtvgZPh3YzpIuZyzdGuk9jJ9xHmnuNA
         zBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870746; x=1780475546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dy1tdo3WsNXJ1hXO7TcI9ffqFZPej1pmbFWn2tPCdc=;
        b=GiyFhyyENRIU9VUclBZHeU03mmz7tr5cecy8OWn7OjlL/K+h53cNxMDgrDnPmsrZtI
         OkSbdpm/tcOMrigUnFDRjR5ICEBgS/cc5gZC0hBYhoziWlqQFeJd82Vv77FojR50uhes
         TJoM9BVMy+yccM3YCHAv2zukz3VDmAuBmykGkzIPr+BFDeUpF3rH9eM7arhebsrHyC6r
         TUwqalImdMJUd3FzRdV30V7UdBPLFVCco71VE00X3npLhBwyBuIDNBVfj49u8+f38Dni
         EKniYeS8F/AByd3iV6YQcYjLVXNpaVpW+oBVy721eNqL8ES77OYOlzFH7OBhOmIBpYYx
         EjBw==
X-Forwarded-Encrypted: i=1; AFNElJ8iSfguZCHHPv+Nl4YCkIhnSYGdJv3iKDQXlnaaoefVZXocvZXv8epXGdL9LEss6rjAFSd5rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwInzbfZgK5ov8PODgABMRRNbDRZ3v9cHOZAy2726DjU8WYNE3t
	I6z5LHcSOPoiadSIYF0YsLJnNVyscqtETTlv/YdZvPd1vUmMAhnvZElE
X-Gm-Gg: Acq92OEtupq2CjUZyfjq0uW5wWX21uTjmarKCwNik7BRQ2ZpyKbMwoaiJh+z0jZwkNh
	XmBEBfqIuzERfpRgIbqRBV3As3AdDfrO/urs8gh3DzzLAGkNjA6OPEjU8nhNoo2khrOkP51ckdg
	I4GDMS1VvSAsG/ZNjE/tBkT1dP/Sgg4FCjMil0pLfl17CWXNF6X6hri74tDmm2b9rlulDa36XIe
	9cwftw7rJDqA1RBKApetajTJATrfSLUkelUOVTxLZH3PmQRL93x+QHRgJ1NxW0TRgjoTZNntGu6
	c1mTvgjxZKDiMZAbSZBq/QhQcJwV+dcgIBbMTHwGdgWblnpZz9ZmMD99zLv6yZg9Icdn1cSVFLs
	KasVdEmXWWQLCkJr+zMl1iGPo4OpmJns+vi9vhppNTqk8Drr2KcILZwESRRbIf1ufinWOhq5kDH
	1sWl2iKCbU399n5jHwFXfkzxKiTIXcUDdiQ9A=
X-Received: by 2002:a05:6000:25e3:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45eb38a6b5amr32754854f8f.35.1779870745674;
        Wed, 27 May 2026 01:32:25 -0700 (PDT)
Received: from foxbook (bfe246.neoplus.adsl.tpnet.pl. [83.28.42.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm7444880f8f.10.2026.05.27.01.32.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 May 2026 01:32:25 -0700 (PDT)
Date: Wed, 27 May 2026 10:32:21 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260527103221.7f8b15b0.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
	<20260518083339.507e24bd.michal.pecio@gmail.com>
	<CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
	<20260522110328.0d3eecd8.michal.pecio@gmail.com>
	<CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
	<20260523022944.59799d83.michal.pecio@gmail.com>
	<CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
	<20260523102815.5c05c70a.michal.pecio@gmail.com>
	<CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Adding Intel IOMMU people.

Context:

Desnes reported xHCI issues duing crash kernel boot after SysRq
triggered panic. Turns out, the chip gets an IOMMU fault, some other
devices also do. Faulting address is a successful dma_alloc_coherent()
allocation in xhci_alloc_erst(), no evidence that it's freed before
the fault occurs. No problems during normal boot.

On Wed, 27 May 2026 00:47:53 -0300, Desnes Nunes wrote:
> # grep "alloc ERST\|free ERST\|ERST\|Device context\|fault addr" kexec-dmesg.log
> [Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f06000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [Tue May 26 08:41:56 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f19000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [Tue May 26 08:41:57 2026] DMAR: [DMA Write NO_PASID] Request device
> [80:1f.6] fault addr 0x106f1c000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> [...]
> [Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: alloc ERST at
> 0x0000001075140000
> [Tue May 26 08:42:01 2026] xhci_hcd 0000:80:14.0: ERST deq = 64'h107513e000
> [Tue May 26 08:42:02 2026] DMAR: [DMA Read NO_PASID] Request device
> [80:14.0] fault addr 0x1075140000 [fault reason 0x39] SM: Present bit
> in Root Entry is clear
> 
> ^ PS: Different address alloc on kdump though
> 
> > Otherwise, it seems you were right that you have some IOMMU problem.  
> 
> Thus, I started to investigate this front now. This time I gave some
> more attention to these dmar messages:
> 
>      [Tue May 19 08:17:49 2026] DMAR: Intel-IOMMU force enabled due to
> platform opt in
>      [Tue May 19 08:17:49 2026] DMAR: No RMRR found
>      [Tue May 19 08:17:49 2026] DMAR: No ATSR found
>      [Tue May 19 08:17:49 2026] DMAR: dmar0: Using Queued invalidation
> => [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from  
> previous kernel for dmar0
>      [Tue May 19 08:17:49 2026] DMAR: dmar1: Using Queued invalidation
> => [Tue May 19 08:17:49 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 19 08:17:49 2026] DMAR: Copied translation tables from  
> previous kernel for dmar1
> 
> I started wondering if maybe on my system these translation tables
> can't be fully trusted for some reason during kdump?
> Maybe iommu is copying root_entries with the Present bit clear, and
> thus generating the fault reason 0x39?
>    -> bus 0x80's? Both ethernet and xhci_hcd fault addr were on this bus  
> 
> So, to test this theory out, I tried to disable translation and
> allocate a clean root-entry table right away if I am running a kdump
> kernel:
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e236c7ec221f..de673f34f4e1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2135,24 +2135,31 @@ static int __init init_dmars(void)
>                 if (translation_pre_enabled(iommu)) {
>                         pr_info("Translation already enabled - trying
> to copy translation structures\n");
> 
> -                       ret = copy_translation_tables(iommu);
> -                       if (ret) {
> -                               /*
> -                                * We found the IOMMU with translation
> -                                * enabled - but failed to copy over the
> -                                * old root-entry table. Try to proceed
> -                                * by disabling translation now and
> -                                * allocating a clean root-entry table.
> -                                * This might cause DMAR faults, but
> -                                * probably the dump will still succeed.
> -                                */
> -                               pr_err("Failed to copy translation
> tables from previous kernel for %s\n",
> -                                      iommu->name);
> +                       if (is_kdump_kernel()) {
> +                               pr_info("DESNES V2 IOMMU kdump kernel,
> disabilng translation and allocating clean root-entry for %s\n",
> +                                       iommu->name);
>                                 iommu_disable_translation(iommu);
>                                 clear_translation_pre_enabled(iommu);
>                         } else {
> -                               pr_info("Copied translation tables
> from previous kernel for %s\n",
> -                                       iommu->name);
> +                               ret = copy_translation_tables(iommu);
> +                               if (ret) {
> +                                       /*
> +                                        * We found the IOMMU with translation
> +                                        * enabled - but failed to copy over the
> +                                        * old root-entry table. Try to proceed
> +                                        * by disabling translation now and
> +                                        * allocating a clean root-entry table.
> +                                        * This might cause DMAR faults, but
> +                                        * probably the dump will still succeed.
> +                                        */
> +                                       pr_err("DESNES V2 Failed to
> copy translation tables from previous kernel for %s\n",
> +                                              iommu->name);
> +                                       iommu_disable_translation(iommu);
> +                                       clear_translation_pre_enabled(iommu);
> +                               } else {
> +                                       pr_info("DESNES V2 Copied
> translation tables from previous kernel for %s\n",
> +                                               iommu->name);
> +                               }
>                         }
>                 }
> 
> Didn't had time to check ERST or HSE yet, but with this I didn't had
> any DMAR faults, vmcore was collected normally and system rebooted
> smoothly afterwards:
> 
>      [Tue May 26 22:52:58 2026] DMAR: Intel-IOMMU force enabled due to
> platform opt in
>      [Tue May 26 22:52:58 2026] DMAR: No RMRR found
>      [Tue May 26 22:52:58 2026] DMAR: No ATSR found
>      [Tue May 26 22:52:58 2026] DMAR: dmar0: Using Queued invalidation
> => [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,  
> disabilng translation and allocating clean root-entry for dmar0
>      [Tue May 26 22:52:58 2026] DMAR: dmar1: Using Queued invalidation
> => [Tue May 26 22:52:58 2026] DMAR: Translation already enabled -  
> trying to copy translation structures
> => [Tue May 26 22:52:58 2026] DMAR: DESNES V2 IOMMU kdump kernel,  
> disabilng translation and allocating clean root-entry for dmar1
> 
> Seems like a lead on this iommu front.
> 
> The funny thing is that the comment in this section literaly says that
> doing this could cause faults, but here clearing it actually seemed to
> solve them and made kdump succeed - commit
> 091d42e43d21b6ca7ec39bf5f9e17bc0bd8d4312 ("iommu/vt-d: Copy
> translation tables from old kernel")
> 
> Let me do some more tests to dump and check the root-entry table
> before clearing, as well as to check ERST allocations and HSE value,
> and I'll get back to you Michal.
> 
> Best Regards,
> 
> Desnes
> 
