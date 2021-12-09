Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23876C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 00:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62CBD4029B;
	Thu,  9 Dec 2021 00:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DiAbd58hib9O; Thu,  9 Dec 2021 00:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EA734027F;
	Thu,  9 Dec 2021 00:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEB84C002F;
	Thu,  9 Dec 2021 00:03:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67BB6C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49D164027F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mF3ZLCJRStM for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:03:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B94240143
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:03:02 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 cq22-20020a17090af99600b001a9550a17a5so5585848pjb.2
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=X62bE6CLRrDuAya/H+kftwzmeQrc/YHKc2dwHO0HL5o=;
 b=Lh7N3FyYDemct+c/y/0ovna7PQvMnUPIJBk1YkcB4n4GWv4rK+B3EaN5IJBAZbkpfE
 cFUurmkHNt+wJrC/DuHyrC4WIzM9R2xe9QiXoNvn+uvH0rOvxtaR8JxzGipJ7FmCrZWT
 /YxCEOb4DQbovGk7ZQeCNgfxBwX61dmLzfVF8hWRDl47ldGCz5AZufBKO8tVYD5X71RN
 N3wsYCmuam1uwueQNbmZPEMITSEhRO2/gtkNxb4mGSs1CSGWQAeqj5r7Y/MUY2R5K0J1
 wu2VC4ANQywCuEUjf7/kuEdImsuzZVgm8p2LyYRNstkeU9pm3Im+F3lNaICBbypsewEs
 EvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X62bE6CLRrDuAya/H+kftwzmeQrc/YHKc2dwHO0HL5o=;
 b=Ch8OE2TFD960N1izxXOR79DJ49LgEos5AVfuFrMpyFQ5CUJJ12hmuiZNuw/RwdjaMD
 VT7wHDCdu1MLXrgrgSTylbu7mSb7E5jGQ/GkI3z1k2OXNXHMJy5vFGB/p3wX2qi+XYQS
 2HDj6L/3oN94M21kfWfZisMZG7qkKiMohmDa0BBFnS+NlNjCMimNZb0DXmfDz40etee7
 fK2/UbUTWDEautw1hXcrnJccxbuPkTkYF/QzniD4CnTFfRa5xoODL834356hB8e1zEfM
 IyUMLyUfR7jC9AdV8O6j5dTuOTImmJTbO9MYrlfwpwy6qYtpdWI77DwO/jWbZ2i0/255
 aVHQ==
X-Gm-Message-State: AOAM533M9tedIqemz2kPwm8ITvwRemL6rpSSKccP5+IHhfYnP4TMmCU1
 qDajVg2YwHzWVRcZe4Wvvh9RgQ==
X-Google-Smtp-Source: ABdhPJxH/D11w+IIasOz+qq6RnU8SkmixF5ZjKPn9Z/OesRd3tEiiUAdcxOjQzxnciR5zUlAbVbh3Q==
X-Received: by 2002:a17:90a:1b26:: with SMTP id
 q35mr11073204pjq.212.1639008181593; 
 Wed, 08 Dec 2021 16:03:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id lt5sm3743029pjb.43.2021.12.08.16.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 16:03:01 -0800 (PST)
Date: Thu, 9 Dec 2021 00:02:57 +0000
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbFHsYJ5ua3J286o@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Jim Mattson <jmattson@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> Also got this while trying a VM with passed through device:
> 
> [mlevitsk@amdlaptop ~]$[   34.926140] usb 5-3: reset full-speed USB device number 3 using xhci_hcd
> [   42.583661] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [  363.562173] VFIO - User Level meta-driver version: 0.3
> [  365.160357] vfio-pci 0000:03:00.0: vfio_ecap_init: hiding ecap 0x1e@0x154
> [  384.138110] BUG: kernel NULL pointer dereference, address: 0000000000000021
> [  384.154039] #PF: supervisor read access in kernel mode
> [  384.165645] #PF: error_code(0x0000) - not-present page
> [  384.177254] PGD 16da9d067 P4D 16da9d067 PUD 13ad1a067 PMD 0 
> [  384.190036] Oops: 0000 [#1] SMP
> [  384.197117] CPU: 3 PID: 14403 Comm: CPU 3/KVM Tainted: G           O      5.16.0-rc4.unstable #6
> [  384.216978] Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> [  384.235258] RIP: 0010:amd_iommu_update_ga+0x32/0x160
> [  384.246469] Code: <4c> 8b 62 20 48 8b 4a 18 4d 85 e4 0f 84 ca 00 00 00 48 85 c9 0f 84
> [  384.288932] RSP: 0018:ffffc9000036fca0 EFLAGS: 00010046
> [  384.300727] RAX: 0000000000000000 RBX: ffff88810b68ab60 RCX: ffff8881667a6018
> [  384.316850] RDX: 0000000000000001 RSI: ffff888107476b00 RDI: 0000000000000003

RDX, a.k.a. ir_data is NULL.  This check in svm_ir_list_add() 

	if (pi->ir_data && (pi->prev_ga_tag != 0)) {

implies pi->ir_data can be NULL, but neither avic_update_iommu_vcpu_affinity()
nor amd_iommu_update_ga() check ir->data for NULL.

amd_ir_set_vcpu_affinity() returns "success" without clearing pi.is_guest_mode

	/* Note:
	 * This device has never been set up for guest mode.
	 * we should not modify the IRTE
	 */
	if (!dev_data || !dev_data->use_vapic)
		return 0;

so it's plausible svm_ir_list_add() could add to the list with a NULL pi->ir_data.

But none of the relevant code has seen any meaningful changes since 5.15, so odds
are good I broke something :-/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
