Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58497345ECD
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503499; cv=pass; b=tGu9DjrGWDa/7x/Z3nEP1f0aSvxqf0b2CnkraVlDWhfiW2e3nLHEqK+Gipv7+uWId8EsaQowt7usyZ28wE1BXnisKrHRGjBcJB7+cX9OZoQbvE8QY3SD0Z+SHQvuG/bxQ6CM154/tHSquiUjLvgjPl/2DX9JL0SNU/Lko/fXY8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503499; c=relaxed/simple;
	bh=1GXEgKb8AtQjGH3gyVhgQKefT0eOIVlPpWz4VPRvhEg=;
	h=From:References:Mime-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG4PTwG6eWc5wpRkXAk+9bgbJoKL7LbkoOKyJsD44/a9lgr+E/rrftp1bEdmqxaV/ecOnn27ORv5TSy+woFVbD8KsqxAznr/JskmO3G4ndPpd2xE7K/N3OzbhQYejmuo390GZBCAO8dI0XEDSKJW3TeJ9pKVIdi/O8xg/tjeFjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LFGPbAlw; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LFGPbAlw"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so388453e87.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 19:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786503495; cv=none;
        d=google.com; s=arc-20260327;
        b=p8lw9zHjBQTqeVFbaZVHekqauU22khCSEROdlpq2slwXS4OPpMvEdVd5PsCl0okRz3
         jKAW72Hn/f9rShZxDXMEZUVrQXzaC7Ox/WAIQ5Kaa0+hQQDVBqfteZDcTdGyZUL5ssk2
         XlkYmQ0y8dNYoIsOHA+lF4+rcUf2/8M+HzA9wQNBHbTpIxCj3CiSimkSB4nIudFyhX8K
         UStM3jBScLz4wCarprtpX8T8X7KiCOTqFdUOlDlPU0GRP32QC6VY23Peq0vr6JccNLPv
         MD98jv1gfSuurgmaYWcDLrg+TiaKh2a7In1AbfCKx5Qke2RjK/31lNxur8WGk6QRgqpV
         oVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:user-agent:in-reply-to:mime-version
         :references:from:dkim-signature;
        bh=i7nGgYKvE3Q27EURwBk0VQlh8/ubhEqw0Zh7p9xqrfQ=;
        fh=w5TwcyvNTMBxF0WHVAiyUcOvDEmkB1SYQqOBUN+L17Q=;
        b=BV0plUG8HNq72SpQKM41f/tXXLSiFH8BICLEN0E8pNDSSQ7mxUTM31a2/iN/Wkrh/A
         m7Dm4TUVan6NaMwROHz27/GquNdWE7EEpaGZtPCM1Cvc8ogu+1hmewFfC05lc2whGqd/
         NxD2Ev2QWhJk+z0ALgHafbjAMjPRxnv15a9ipgD7Gw22Oez7lfqP5CudfpNzfrCTaRMz
         LvFwOhY+qgdrlbr2KUqO5qf4IrDdVKapSp6kMlC8wncviTTryf6CnTOYdbF2ckAkhe4k
         zH6EtDn7pLjnaKKBqHVIwxhnEXW/ozbRyEaynAhAGlzyJkQyePui7aGigZzPXqLOrclz
         Dcsg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786503495; x=1787108295; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:user-agent:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i7nGgYKvE3Q27EURwBk0VQlh8/ubhEqw0Zh7p9xqrfQ=;
        b=LFGPbAlwMxDWPbHkczIz49R1QFmmXmR8wXUfz7kAwxUTLHV0c13Yw5XVtmwk1ZYn6m
         SZQ/syXaS0ICVPFjzSjmK1BzELKPEQy2IkLrbsmy5aDB7ASxX9sj7dYLeADLhGQQV9pR
         MZx7kHXwh53MxP9yplFTVYh3QEurdAHjiHpleBIE1dXXuVOSMTib+SrxLZ7CTKCRlX8O
         qwf63kl1eMs5lCPl+jPc+wvcLwjCID2GHx1VwwE3xW/AaoiFN2kUXyUNBN/X4vd6/AWp
         nC7o0aI5oTM0fE5dqOlVGhAlXU8Ej5AoXuS8JYKPqPZDxsAmvDF2p8CkHUbSsJwd3zMr
         dxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786503495; x=1787108295;
        h=content-type:cc:to:subject:message-id:date:user-agent:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i7nGgYKvE3Q27EURwBk0VQlh8/ubhEqw0Zh7p9xqrfQ=;
        b=JNyq8GlgnvRLArQF15Kw9seLxrrNNxGWpZNsycULssBFbdwmbJMw+JXpVLms/ymn2h
         IJXSXXIVkbXeDfkG+qefPgUEXxIItF8Xo1W1ka70HZDtkxiR7L7EohKiIikH2KD0WyJq
         9IwlEUSaLfgjue5t7cIBd3FlZt82Z2O/0vPHJXiJPtcgEw0Uz7e36TCtjQUR4p+pnnJo
         NBKUL/IomgyVz0ilh9Q9e1uVSDJfGEAnsaUG9wG7B19J0oQWJ0QyaffAtCgY4poqfmkP
         8MwCXtO1vbaR9uSyZvOCgieEkK1oZsmXaM/QfOkaQNpYafk15MwB7fEa/3oF/0t4/sDS
         g4GQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrm/e9qVQc5poN2FtMk3YNHn1PzpClvrNBOccGu8tMSehrf9yEUds52QtjR5LsJSiO9iGlYnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnGNhMLQIgMtz+NC2EEgf8d/ti+An5nHQsPCsElA/7Gl5XyDio
	luBbQdHSDO+VCqg0x/cCGetQVwPOvjEFcInX2CWn1uqZwsi9XZfBDMoaVAcGmz1n7LjSc9xgFwb
	6Gl8LlbEiBvlmyjG53aL6BslOYHbjZ7JVj2pABujH3A==
X-Gm-Gg: AR+sD11cekEJ8bmrthrAEtw+nVCaMZCxKvW4AUBUret7XwKdP645lhLDAeJ1yjDIDIE
	83NdKEJUYfTZfNInuAFF1iVj/5mp56Z+YaCjORPgyPatVCgptXCYH1kvguxQpSsAa93z9NdBa2X
	JB3Sjxul2Nij4fSP1wbnHmzXgf4B465PfsSxfU3nvQE9/+e8tmaZMJPJbOG9jXbQ7HFgcksOkkr
	CGn3Nqs7BhWvBe6hYQSGH2aBtLRiHFL79Q3YmTma23N5Ffxt02WEL2u+txu/ctBeHtFWOrRw8q+
	dvI126Nd1j6alLb0X9LUHqTG6LVB/jjSytLwYeI1TpsMjGYvWEgazQ59
X-Received: by 2002:a05:6512:6883:10b0:5ae:ba47:e7bb with SMTP id
 2adb3069b0e04-5b44e327b7emr127630e87.36.1786503495339; Tue, 11 Aug 2026
 19:58:15 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:58:14 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:58:14 -0700
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-4-zhangzhanpeng.jasper@bytedance.com> <anvYGuNF3MC//Q94@x1>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <anvYGuNF3MC//Q94@x1>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
Date: Tue, 11 Aug 2026 19:58:14 -0700
X-Gm-Features: AUfX_mxvwZ83pSWvPns7jRPE3EZ4ROM6a0cFBGgGRZzehYP0r9bHWpi6TB0BXXM
Message-ID: <CACnXVnfHZ0icevM8B3rVCiU_qxm41W+duRkPRS8HP45P05abYA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] resctrl: Add a devices file for external
 requester assignment
To: Drew Fustini <fustini@kernel.org>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com, 
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, 
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Drew,

On 8/12/26 10:19 AM, Drew Fustini wrote:
> On Tue, Jul 14, 2026 at 09:06:53PM +0800, Zhanpeng Zhang wrote:
>> Do not overload the resctrl tasks file with architecture-specific
>> non-PID tokens. The tasks ABI remains a list of task IDs, while the new
>> devices file carries external requesters assigned to a resctrl group.
>>
>> Add architecture hooks for assigning and showing those external
>> objects, and reject group removal, reparenting, or pseudo-lock setup
>> while devices are still assigned. The teardown path performs a
>> best-effort reset to the default group.
>>
>> The devices file is an assignment interface only. It does not describe
>> a new resource schema or domain; resource allocation and monitoring
>> policy remain described by the existing schemata and info files.
>>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   Documentation/filesystems/resctrl.rst |  26 ++++
>>   arch/Kconfig                          |   6 +
>>   fs/resctrl/rdtgroup.c                 | 206 +++++++++++++++++++++++++-
>>   include/linux/resctrl.h               |  45 ++++++
>>   4 files changed, 280 insertions(+), 3 deletions(-)
> [..]
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index af2cbab14497..2e424c911049 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
> [..]
>> @@ -2067,6 +2236,16 @@ static struct rftype res_common_files[] = {
>>   		.seq_show	= rdtgroup_tasks_show,
>>   		.fflags		= RFTYPE_BASE,
>>   	},
>> +#ifdef CONFIG_ARCH_HAS_RESCTRL_DEVICES
>> +	{
>> +		.name		= "devices",
>> +		.mode		= 0644,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.write		= rdtgroup_devices_write,
>> +		.seq_show	= rdtgroup_devices_show,
>> +		.fflags		= RFTYPE_BASE,
>
> Once CONFIG_ARCH_HAS_RESCTRL_DEVICES is built in, the file shows up in
> every resctrl group directory, even on hardware whose IOMMU does not
> implement QOSID. I think it would be better to make fflags zero so
> rdtgroup_add_files() skips it, and enable it at runtime from
> resctrl_init().
>
> Thanks,
> Drew

Good point. The build-time architecture capability is not sufficient to
expose the file. I will look for an appropriate runtime mechanism to
control whether the file is exposed.

Thank you for the careful review. I really appreciate it.

Thanks,
Zhanpeng
