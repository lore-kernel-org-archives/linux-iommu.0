Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1420326
	for <iommu@lists.linux.dev>; Fri,  1 Aug 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062388; cv=none; b=u42DYgohy1TBphmwt8LHRz2HQ5CjVlNoAjhPpcIuoZLPcBb3S2fF9xLW1hCSKbZvakllXK6POQgwpQSssjCFbR6UJD8Hq6CcAOK0oB2y2req4ItannjT1AR0uQJfiUkUx1hwXfy5E9XtEqPeR05zDjqIpJW507fYfOEL0/aNGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062388; c=relaxed/simple;
	bh=76zm5mLsx7bheh6RWXQy50AwQ/nwArGGKpe4OQEkatM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GOjInSwFb1yzaCC5uBzS3mGFF7Fhz6bfsnMutYzrXTk5afhZ60jCQHi0iCpoFjpRZvdiY/n2URInVZTxAjHhMf+Jv9/c1IBXmT0V/Gp91OpqpH2QyJwwWgwBjj8n03HnPMtLMh6AG4yP8Yhbm29vcBH/6COH3eFD4i5wEInDtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJSVWqJr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJSVWqJr"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3322d1dded6so20054661fa.2
        for <iommu@lists.linux.dev>; Fri, 01 Aug 2025 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062385; x=1754667185; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=JJSVWqJr8g10gWxO4rODD3vZUUT0U9gzcfrNg+J3L+3bTSY8u2lJZkf/fxD36uTG0Y
         daNIgs6ZkguJzVt93yYoS3/WyD+yiWDp+9+lcUj+PrlXLe1pEXv3RL4+Fq6dTCb9TzXP
         fT71zoYO2B6fjCUwtO3bg1CuMVuCTcogwsbN39HgibxGqrzB8qk+fcnkM+kqOShc23ph
         hk9BGCumdHlPe9Km/tpW1C40D/G7+D6SGtzCpYevB+sPLkW0LA59+qIOeL9UEMpM2NZ+
         4RuGOeXk/panrWMLnmz93sRUL6X4CoY8GSF2wLQQntqMw5c/JNRyHuXVJjopDMSjSdLZ
         6n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062385; x=1754667185;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=SsA6F2Urf1e7cRhOEViIoOfQ9kwjZNDzt74myoYQNZ7/IUWgEA50OnFsLfzQA2gbEt
         gaRofKS0LKfc0xG4T3OKBNgF0v2HjithMSKov9OL5m9Eht1SfM42QzduaIYle1SUeX3J
         Aza8FwGKPnNbpECNG5r8g+C7ZpGjHfeaC0bhIPeUjtbmjs+evnyY+PTkI6ShTKnbeGcO
         +3KfUsHblvFzKACBYIJ9896etL3FQ6mzJY1yLPzWj5df2GuLYL7VKe15SMreLP0YdX85
         Zl/bErUOHevSYbk56emL3S0M4gCTeGK6pmYlc4TZmWnNUMsGdRjSSPwnskQVOJOkbBRP
         AGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJa9Dj3QUQngPDDbrJE7msc8XEBqjGM5XPkAZr3GIzx8uUR4zP00mUfcpnBNXviOaXgeT+Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGEOHvBBwVtPalFlqfgS+O1QPFLgsPP/Oi211pkwuKAHzV/maG
	BSgJ7cdhTnb0tKiFa+DZ64Gy4jFkn0jGmmsiisNxNtBwJP2Ko4bz5LL/lr72JloZUnxWFqomm1p
	KMlVdGmLaA+xWPc6BgIG6shf2F1xfhOFjeSgTEVxC
X-Gm-Gg: ASbGncu4+C8TxOV5o6MYErz0qns54s2HnL0vF8Zc7CBFO/3Nb+yJlMChyRukyhPKbmP
	q6vjpwoujJ4drYz6wApDFVMZWbq3TiWp3eXudTGKLLIrrozt/7z6lBOO+JyBkL3fScDVtGb4b+q
	XQWj7IxQ9fjD8MkFKw7qnQiUwoa/7ULn3eEAZcMGyPYminEaw+9cYZhigqpubBVx7SQ9Kgrsc+t
	gtrM/XpD//iGP9YWw==
X-Google-Smtp-Source: AGHT+IElqGqJCtZOhO3R6EOALjhIxAosCdG4c6JAw0Ii5GIvvlZsjTd7NWmVyt9CTRdEgA600P6iKWvTGZcKiA6jmn0=
X-Received: by 2002:a05:651c:4117:b0:32e:aaa0:b06a with SMTP id
 38308e7fff4ca-33224a5e95emr27853181fa.8.1754062384765; Fri, 01 Aug 2025
 08:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 Aug 2025 08:32:37 -0700
X-Gm-Features: Ac12FXzLKnSwpLBskXSaJfx0o2ePwkZV7fNIT0lZA44HGFkBJgr6jkivWR4r114
Message-ID: <CALzav=d_Bjfy=6if+rPmxgGJfUV8ijnQ5hf40HoH6Yozg_H6Ew@mail.gmail.com>
Subject: Live Update MC (LPC): Call for Presentations
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, kexec@lists.infradead.org, 
	Linux MM Mailing List <linux-mm@kvack.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Cc: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chriscli@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Changyuan Lyu <changyuanl@google.com>, 
	"graf@amazon.com" <graf@amazon.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, "ptyadav@amazon.de" <ptyadav@amazon.de>, 
	"jgg@nvidia.com" <jgg@nvidia.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu US <witu@nvidia.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, dave.hansen@intel.com, 
	David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>, jork.loeser@microsoft.com, 
	Junaid Shahid <junaids@google.com>, pankaj.gupta.linux@gmail.com, 
	Pratyush Yadav <pratyush@kernel.org>, kpraveen.lkml@gmail.com, 
	Vishal Annapurve <vannapurve@google.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

We are pleased to announce that there will be a Live Update Microconference at
Linux Plumbers 2025: https://lpc.events/event/19/contributions/2004/

This microconference aims to bring together developers from across the kernel
to discuss topics related to Live Update support in Linux. Live Update is a
specialized reboot process where selected devices are kept operational and
kernel state is preserved and recreated across a kexec. For devices, DMA and
interrupts may continue during the reboot.

The primary use-case of Live Update is to enable hypervisor updates in cloud
environments with minimal disruption to running virtual machines. During a Live
Update, a VM can pause and its state is stored to memory while the hypervisor
reboots. PCIe devices attached to those VMs (such as GPUs, NICs, and SSDs), are
kept running during the Live Update. After the reboot, VMs are recreated and
restored from memory, reattached to devices, and resumed. The disruption is
limited to the time it takes to complete this entire process.

With Live Update infrastructure in place, other use-cases may emerge, like for
example preserving the state of GPU doing LLM, freezing running containers with
CRIU, and preserving large in-memory databases.

Topics to be discussed at the microconference include:
  - Live Update Orchestrator (state machine, userspace API, implementation)
  - Generic infrastructure for preserving file descriptors across Live Updates
  - Live Update support for specific files (memfd, iommufd, VFIO cdev, etc.)
  - Integration of Live Update with the PCI subsystem and Linux device model
  - Integration of Live Update with IOMMU and Interrupt Remapping drivers
  - Serializing, deserializing, and versioning kernel state that is passed
    across Live Update
  - Persistence of movable memory
  - Leveraging suspend/resume functionality for device state preservation
  - Optimizing kernel shutdown and boot times
  - Support for Confidential VMs
  - Automated testing

Please submit your proposals at https://lpc.events/event/19/abstracts/ and
select "Live Update MC" as the track. Submissions are due on or before 11:59PM
UTC on Wednesday, September 10, 2025.

We look forward to seeing you at LPC!
