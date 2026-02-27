Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34798234973
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156701; cv=none; b=RmVTMfM+BobPISNpOI97FKTEeyPp1vQJq3wKEAUcn3up6CCHNwOVFyq18X4L9hMxTjTrZOzQX7M8rx38YoFnxK/UeVpyb3ChFxP2u3vK9heDu/w6I7gdKiB1AptH3EhDmKhCqeSPDJ28RnkujeJIc1xgLbYcIKFzYen7isLQ6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156701; c=relaxed/simple;
	bh=NTY89IdzpzMF/vamWnS8uagHAc6qdvmbw2nDVuvCKx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuaxcWdAEXOGuZS5QAQbF2Izy9Z4y3Cya5d6IrPCD3SwrKERO9e17RjHTQrZEw4GacF3hq2yzRuernfCMqam/1aG++I8nIP0J6Cd8FB5BfY/Mp7bLQSvUMHNdSIPcMPE1E1SZblNBlWKSKMTi/fYBxw5q1rBA2UnYhmMG2IHXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vv2LQnoN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vv2LQnoN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ada9e4ea32so24165ad.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 17:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772156699; x=1772761499; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OfQIDC/J7NEbWJLcNCVG4ViZ9Wlry/rF6niI+P+JhNI=;
        b=vv2LQnoN2F8seiDcaMKpbXsSmrjNVMq8lGL7oXQ2AufsjCcIlEWQWSefGSnqTmI4Nu
         XPRGqb99HVA0CQ65w1lTHmSHlfLuOxI+ahrQppGqy3KPBl+86v2Mz9qioqQc7eVFjuBk
         ohkpCvnmmI45bnYMq1dQBdmOQNGf385E+ftS9q9qdsj7HQ0AKeSzgS9DvH3kPDDXsrWR
         ZkN53jXfY1YTR6gkpi1TXpPOp5GEgD+ENAI0ltwdGTYMkUQ4nz5fT61O7Mx0VCScDS/Q
         aTzIUMb/QRsC7hNKv7+ZuaKCUNH8yef334sQoZ5nbPiqJX3jbDheBWfn43+Fc8UfEc+y
         mXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156699; x=1772761499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfQIDC/J7NEbWJLcNCVG4ViZ9Wlry/rF6niI+P+JhNI=;
        b=gYR4CwJuEZHgxieSWkhqlmrdE7KMN9UL4dTGQuDduqrF5IE1X2XSOSUwKVBuJvVs4t
         ALTnc7wmiLOCMXNlc1K0LGXtwTQsxycY8iLaUtOFYUQzPzcKAyzOSp3G+1snhMqM6DdJ
         1mclG4aW1hDh7guoK8OS5sn7ObupIHpI0sVIgJZwRjvVnGztFhOmOGMfbnbLJyDC1kjs
         bGk1ibNWX4NVOu5IBq5DyoiywoPoiEuzuWG1dQYniI4SsePoP6gGVnqfsUs7BLylq9Rx
         DmJwivGnj+t9dCbHE0BAttQH0cM+720a9fDuQ3TqnZy0nNaKKLpKJsS8ygLsNEiBHWpg
         49HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW80v57AP3FXCTZ+8Vk3HmUaQj0B+50IJEKdOKB/h0jcejVN7ZHoM05cBgDlIbwt6v+L4231Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsHDAc9NxtUyUA0awVVj5Th/VkLmzzeUrKkA/Uv3AF4rWC3cm3
	yOwKP4Bt4NwNifHJOhfMOJ0gBLzTrz2JFdnR1Bji7aU5369cXUXlao2KpovluqSVrQ==
X-Gm-Gg: ATEYQzwOUrcAUxQ3E7OH2cek5kiNmzjvfuc0xYYGNLs+JE+dGIJwu9rmOX9/G4/P3CU
	QFqdkbgMRUGBXzSGsaDnaL9IvzGAiFMIccrKhG5Uc5T+W6VNpjNH+5EWzVi9bsTdnI+Wm4gIIrm
	OSnHGgxrRn0o/kyLfRNF05tDxJJ+paxxnq1xgJeeiKo0aFAe8oFaSpi3RBn6NOHzROAMv4SiSz5
	1OpS0EEjNNcU0nmofNGyUQStj0RhxUfUFUHRpG/9drVTmO0u0er27qafI0s3CR8VHDEEREkvnSl
	Gbl4GTuAGxAHxsqxx5vzkpWVyfgU9kN0M9F3Y64OIJDBhBrlaMHdU/Nly+Lw5jjpXJNVA8lRtgn
	1OOLCQSOX8BFRCcZM2nrZW77vcZI1HSf5ays1hh3wIOLGUWxK58utZGSQSophsgQwtbip2/aOxY
	jXJMjGpBybIk7YXj3TKLB2WC6uQXoWHXffxw3KegPrJU6kRE7ELFRhSLa/cRg/ew==
X-Received: by 2002:a17:902:dad0:b0:2a7:9532:1a2b with SMTP id d9443c01a7336-2adf77c6b5fmr4035125ad.20.1772156698800;
        Thu, 26 Feb 2026 17:44:58 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm4658070b3a.21.2026.02.26.17.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 17:44:58 -0800 (PST)
Date: Fri, 27 Feb 2026 01:44:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, "Guo, Jinhui" <guojinhui.liam@bytedance.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"will@kernel.org" <will@kernel.org>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Message-ID: <2ydt4k7saucrkg6pxedfozdg5dsrkfhx5bpqkrdgwrob2dsi4j@tc63xjaw6ltt>
References: <BN9PR11MB5276FCF5D751DE7432A32BBB8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260210233912.GA93504@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210233912.GA93504@bhelgaas>

On Tue, Feb 10, 2026 at 05:39:12PM -0600, Bjorn Helgaas wrote:
>[+cc Alex, beginning of thread:
>https://lore.kernel.org/all/20251211035946.2071-1-guojinhui.liam@bytedance.com/]
>
>On Wed, Dec 24, 2025 at 03:08:49AM +0000, Tian, Kevin wrote:
>> +Bjorn for guidance.
>
>Sorry for the late response.
>
>> quick context - previously intel-iommu driver fixed a lockup issue in surprise
>> removal, by checking pci_dev_is_disconnected(). But Jinhui still observed the
>> lockup issue in a setup where no interrupt is raised to pci core upon surprise
>> removal (so pci_dev_is_disconnected() is false), hence suggesting to replace
>> the check with pci_device_is_present() instead.
>
>I think checking pci_dev_is_disconnected() or pci_device_is_present()
>in drivers is usually bad practice because it's always racy, as you've
>already pointed out.
>
>I don't think it's possible to avoid Invalidate Completion Timeouts in
>general, so I think the real solution is to figure out how to
>gracefully handle them without running into the lockup detection.
>
>I assume the lockup is the loop in qi_submit_sync() where we wait for
>QI_DONE with interrupts disabled.  Maybe we need something like
>watchdog_hardlockup_touch_cpu() there, along with a timeout in that
>loop?

Looking at the AMD IOMMU driver, it has 100ms timeout in wait_on_sem()
that basically waits for the completion until the timeout occurs. Is
this the expected behaviour as per specification, or should the IOMMU
wait for the Invalidation Completion Timeout?

Reading the specs (notes of PCIe r7.0, sec 10.1.1, Figure 10-4), it
seems the device is allowed to send translated TLPs, targetting the
address regions being invalidated, until the Invalidation Completion
Timeout (which could be 1-2 minutes as Bjorn shared below).

>
>The PCIe r7.0, sec 10.3.1, implementation note suggests the timeout
>might be in the 1-2 minute range, which is pretty extreme, but if we
>can at least handle timeouts gracefully, we can think about ways to
>make them less likely, e.g., by coordinating with FLR and VFIO detach
>(maybe the sort of thing Alex alluded to at
>https://lore.kernel.org/all/20251223153534.0968cc15.alex@shazbot.org).
>
>> Bjorn, is it a common practice to fix it directly/only in drivers or should the
>> pci core be notified e.g. simulating a late removal event? By searching the
>> code looks it's the former, but better confirm with you before picking this
>> fix...
>
>I don't know exactly what it would look like to simulate a late
>removal event, but it sounds like some kind of complicated
>infrastructure that would still be only a 90% solution, which I
>wouldn't recommend.
>
>> > From: Baolu Lu <baolu.lu@linux.intel.com>
>> > Sent: Tuesday, December 23, 2025 12:06 PM
>> >
>> > On 12/22/25 19:19, Jinhui Guo wrote:
>> > > On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
>> > >>> From: Jinhui Guo<guojinhui.liam@bytedance.com>
>> > >>> Sent: Thursday, December 11, 2025 12:00 PM
>> > >>>
>> > >>> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
>> > >>> request when device is disconnected") relies on
>> > >>> pci_dev_is_disconnected() to skip ATS invalidation for
>> > >>> safely-removed devices, but it does not cover link-down caused
>> > >>> by faults, which can still hard-lock the system.
>> > >> According to the commit msg it actually tries to fix the hard lockup
>> > >> with surprise removal. For safe removal the device is not removed
>> > >> before invalidation is done:
>> > >>
>> > >> "
>> > >>      For safe removal, device wouldn't be removed until the whole software
>> > >>      handling process is done, it wouldn't trigger the hard lock up issue
>> > >>      caused by too long ATS Invalidation timeout wait.
>> > >> "
>> > >>
>> > >> Can you help articulate the problem especially about the part
>> > >> 'link-down caused by faults"? What are those faults? How are
>> > >> they different from the said surprise removal in the commit
>> > >> msg to not set pci_dev_is_disconnected()?
>> > >>
>> > > Hi, kevin, sorry for the delayed reply.
>> > >
>> > > A normal or surprise removal of a PCIe device on a hot-plug port normally
>> > > triggers an interrupt from the PCIe switch.
>> > >
>> > > We have, however, observed cases where no interrupt is generated when
>> > the
>> > > device suddenly loses its link; the behaviour is identical to setting the
>> > > Link Disable bit in the switch’s Link Control register (offset 10h). Exactly
>> > > what goes wrong in the LTSSM between the PCIe switch and the endpoint
>> > remains
>> > > unknown.
>> >
>> > In this scenario, the hardware has effectively vanished, yet the device
>> > driver remains bound and the IOMMU resources haven't been released. I’m
>> > just curious if this stale state could trigger issues in other places
>> > before the kernel fully realizes the device is gone? I’m not objecting
>> > to the fix. I'm just interested in whether this 'zombie' state creates
>> > risks elsewhere.
>> >
