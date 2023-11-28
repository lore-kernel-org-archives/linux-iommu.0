Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE83457D;
	Tue, 28 Nov 2023 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh+kyIvR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6c115026985so5305741b3a.1;
        Tue, 28 Nov 2023 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701176971; x=1701781771; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8wlpDIqNbi5vLnzI15P5Lxtzc5A7rbfuNGTA7aBUUY=;
        b=Bh+kyIvR3RR3FnyAVN4RibQ28YQo2KDojNuDU4FLIhnTOtf0eYE6f6t+MglSUm4eYW
         k6yoLJdDxqwkuKXiwVxotCtwM1Oqa9jbSItowlTgeWsvCrvw2qm7SrirRVXNDKAHOGKK
         zQ0U/u8Q+F1f59mOhBjZK3wexZ3thfPrHU8Rqkf2ExvrAJ+0Mcnt+/EtvMfBPJvTxH/P
         akE7nVnUKDbar/1cWuvpUKVxqwoHkxk4VRXAjQgy06kCGIF6GwfsXKcxxiGGyDugVIR1
         vlAEptdVHLA3K+DFFEOXYULjYOJEdk8HY6wzb6Isn/vMT4x2jjFj/tQg8pSk2wfvgViX
         mK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176971; x=1701781771;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A8wlpDIqNbi5vLnzI15P5Lxtzc5A7rbfuNGTA7aBUUY=;
        b=gjlasLQ6hsJl23v45p4JsNrGoRE0nANMD8NCoG0vchNglObf404KgAANyRMIX+HNrA
         MX6cD8GdhaiWjtD5HB3O6jnT26Y9MRB8tkDc96fukA8ImweRulmzjl2wQBLKgtptvrSQ
         5O7kZrE7IOr884d2mIVrfrQ723mBkXhb4It0pFIeD1edhYmd9HUosJ07xT6Lc/fMfUEw
         6MMCKggQj+AgDqzRl4tj+CODNiV1FuLcsx87ufrWHnCVCuIwE1f+D1qp4x9sw807Z7Fl
         eLXodh/PgYri7CxhoiE4JyV2CJOW7lkU56zGe6G4FKYMJm4cI/iYF0Qhm8wQ8lghcn5b
         4Dvg==
X-Gm-Message-State: AOJu0Yzi7hFRDXOczX/TEQ31ONoj2Lj7Tn51z4llmzEp3Dm3FWUppRTK
	a09OEVh6lz3OrKfufdrygko=
X-Google-Smtp-Source: AGHT+IFPqMtwLgpXsxzmkLwbwnT2E+yfl9IJPiQNoF7hcNQN73mIlZ/wQyvyYleB711N0rjXyFYIxQ==
X-Received: by 2002:a05:6a00:3909:b0:6be:130a:22a0 with SMTP id fh9-20020a056a00390900b006be130a22a0mr16638210pfb.14.1701176971167;
        Tue, 28 Nov 2023 05:09:31 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s6-20020aa78d46000000b006cbb5f2cbe0sm8768749pfe.102.2023.11.28.05.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:09:30 -0800 (PST)
Message-ID: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
Date: Tue, 28 Nov 2023 20:09:24 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux IOMMU <iommu@lists.linux.dev>,
 Linux Power Management <linux-pm@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 kbugreports@proton.me
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernels v6.5 and v6.6 break resume from standby (s3) on some
 Intel systems if VT-d is enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Note:
> 
> I'm just a Linux user, I don't work in IT or even write code, so, I'm probably using terms to describe the issue that are not the ones someone who knows code and what the system does under the hood would use.
> 
> Affected system:
> 
> Thinkpad, Intel Kaby Lake (i7-7600U) chipset / cpu and onboard gpu (Intel HD 620), no separate graphics card, current bios firmware; running Void Linux, xfce / lightdm
> 
> Symptom / problem:
> 
> Since the upgrade to kernel v6.5.5 (from v6.3.13) my system doesn't wake up from standby, i.e. resume from s3 fails 100% of the time.
> When pressing a key or the power button nothing happens. The LED that indicates different states of the system, keeps indicating standby mode.
> The only way to use the system again is hard reset by pressing the power button for a few seconds.
> 
> So, there is no crashing on resume or incomplete resume or only sometimes failing to resume or failing to go into standby in the first place.
> 
> Granted, this issue was present with kernels before v6.5, but only occasionally and it would not re-appear for many many boot cycles. So, I never had any lead as to why it would happen.
> 
> I installed kernel v6.4.16 to test for the bug - it's not in there.
> 
> For further testing I also installed kernel v6.5.2, as this was the first kernel of the 6.5 series available on void linux, (and because the kernel logs mention VT-d for kernel v6.5.5 and v6.5.3, see below). Result: The bug is already in v6.5.2, too.
> 
> There's only one thing I noticed from comparing logs between kernels v6.5/6.6 vs v6.1/6.3/6.4. In the moment the system goes into standby, if running one of the latter three kernel versions the system would print the following messages:
> 
> [elogind-daemon] Entering sleep state 'suspend'...
> [kernel] PM: suspend entry (deep)
> 
> 
> But with kernels v6.5/6.6, the kernel message is missing, only the elogind-daemon message shows up in the logs. As if the kernel didn't get the memo and thus didn't prepare and didn't listen for the wake-up call to resume.
> 
> 
> To see, if this is a bug that might be tight to a certain chipset / cpu generation, I tested kernel v6.5 on my old Thinkpad (Intel Sandy Bridge chipset / cpu, and also onboard graphics only). Its BIOS also has VT-d enabled. Interestingly, on that system, resume from standby with kernel v6.5 is no problem, even though its system is set up the same as the current Thinkpad.
> 
> So, this bug seems to be limited to certain set of chipset / cpu. Which seems feasible, as I couldn't find a bug report on this - not too many seem to be affected.
> 
> 
> 
> There's an older bug report on similar symptoms, but the cure doesn't work on my system:
> 
> "intel_iommu=on breaks resume from suspend on several Thinkpad models"
> https://bugzilla.kernel.org/show_bug.cgi?id=197029
> 
> 
> Although it sounds just like what my system is experiencing - apart from the fact that term suspend being sometimes also used to describe hibernation and it is not specified which one is meant in the bug report.
> 
> So, I was hopeful on the one hand that the (workaround) fix (adding intel_iommu=off to the kernel parameters) would work on my system, too - on the other hand, this bug report was for kernel v4.13, so it's probably not necessarily relevant to similar symptoms with kernel v6.5 and v6.6, respectively.
> 
> Anyway, adding intel_iommu=off to the kernel parameters didn't change anything on my system. I made, of course, sure once the system was running, that intel_iommu=off was in indeed used as one of the kernel parameters.
> 
> 
> With this information in mind I did a regular internet search and found some information that in case intel_iommu=off in the kernel parameters doesn't help, disabling VT-d in BIOS might.
> And in my case it does indeed help avoiding the bug - for both kernel versions, v6.5 and v6.6.
> 
> Reading some other bug reports and some changelogs, I noticed that iommu and vt-s are connected, to I posted this bug report in drivers/iommu. If it is misplaced here, please feel free to move it to the correct category.
> 
> 
> I attached a file with the output of some commands I found being used in several other bug reports on here, just in case they might be needed / helpful.
> 
> 
> Thank you very much for your help in advance!

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.3..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=218191
#regzbot title: resume from standby fails on Thinkpad with Kaby Lake CPU

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218191

-- 
An old man doll... just what I always wanted! - Clara
