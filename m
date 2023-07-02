Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF841C04
	for <iommu@lists.linux.dev>; Sun,  2 Jul 2023 12:13:26 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6686c74183cso2794374b3a.1
        for <iommu@lists.linux.dev>; Sun, 02 Jul 2023 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300006; x=1690892006;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vudbneyh5amlB4z/hjEg2kh8mq89mabibesrDE7OD1s=;
        b=DQF0vQEwTZm8Zhqubzz0/nOFbE7PT5ekj0ujozi8GUbmatpmKXwlNUYv+O1k6lfCrp
         u9q3sKI2PYPwl/rQgddi/YqX0Mq3s9kE5pFJcWoqi/DLoqe9JpDl1ML2etydSY/07g9C
         w1l2alCysL3UL9ia8c/NuzaNYzyweUjqvSD/IIq62aQ18EHhQyy9t0fAaxfA61itBDlv
         YvsVkhPZmrhxqaLehOhExG2nxfFfW/MQtmwQzHDBIuHZADL+KQJtqorCL7pPRlLqQmtU
         SS47Vwu3OV+xOxfagSLq1XXSBteqYfPoJ35Kd2z7YxrngyY/KlX5PBgcMkI/T7XqCw2c
         DdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300006; x=1690892006;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vudbneyh5amlB4z/hjEg2kh8mq89mabibesrDE7OD1s=;
        b=RwjWJULxSCoaKxUhhyeHa83IOXi0/yYMrxyfGsW/+KhCWCSl7GIn06PK1wgTRE9S4D
         qRtzxGGpjJDUqk97eAbeNahwdS6B1YNvS6839fj/ScubsfOPIJZNKX/LTkx08avjh0BU
         Fyre/qKoTZNMsxYc2GbPD1MdMZwCa4jBotEiDh1XVJDFj9Uz+gPyNYh/oLvgDDpV5wPq
         RTWmbhm84bEqTD6wgnM2HxoBwEG24xQxi6bmAFQ67YbCtF1M0FWveEEe5Yyl6qlh42Qp
         SvKykVj/zIQ3+1GLxgK/ENhCdA7jmxzfXUfgyhg/qXvWqTAoKMjCWWhC0mdkXIK0Dfih
         rCrQ==
X-Gm-Message-State: ABy/qLZKDBzzIBUByWYE/Nz1Yos9RJVptD+bAXDyla1BvxA+wq7bEr2j
	eft4g32f/kHe4czJ71PINm8=
X-Google-Smtp-Source: APBJJlGAwoTaYP/5ZAs1gTB/kctY9tt1kXkLpAl+wW0iwuTI7cUuoIUoFng9hsTELVCezx4xSv5i2Q==
X-Received: by 2002:a05:6a00:1341:b0:674:6dd4:8337 with SMTP id k1-20020a056a00134100b006746dd48337mr11833992pfu.12.1688300006187;
        Sun, 02 Jul 2023 05:13:26 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b005d22639b577sm8566434pfv.165.2023.07.02.05.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 05:13:25 -0700 (PDT)
Message-ID: <a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com>
Date: Sun, 2 Jul 2023 19:13:14 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Johannes Berg <johannes.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
 Nate Watterson <nwatters@codeaurora.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Linux IO Memory Management Unit <iommu@lists.linux.dev>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: iwlwifi causes dma-iommu.c:693 __iommu_dma_unmap since commit
 19898ce9cf8a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a regression report on Bugzilla [1]: Quoting from it:

> Since commit 19898ce9cf8a the iwlwifi has generated three possibly identical kernel stack traces for me. Because I only use the Bluetooth but not the Wi-Fi functionality, this is not a big deal for me but I thought such an issue is worth reporting nontheless.
> 
> All three traces point at **drivers/iommu/dma-iommu.c:693 __iommu_dma_unmap+0x150/0x160**.
> 
> I'm attaching to this bug report the three stack traces along with other possibly relevant dmesg parts. Sorry in advance for not cutting at the cut here markers which resulted in considerably longer text but I suspected that the PCI, ACPI, memory and possibly iwlwifi related messages may be of importance, too. If I should cut the stack traces out and attach them as three distinct files (and diff to see if there's any change between them) let me know. I can provide a full (but redacted) dmesg output of a git master build, if required as well.
> 
> I did try booting a much more recent git master build with *iommu.passthrough=0 iommu.strict=0* on the kernel command line but that did not seem to make any difference.
> 
> ```
> 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
> commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Jun 21 13:12:07 2023 +0300
> 
>     wifi: iwlwifi: split 22000.c into multiple files
>     
>     Split the configuration list in 22000.c into four new files,
>     per new device family, so we don't have this huge unusable
>     file. Yes, this duplicates a few small things, but that's
>     still much better than what we have now.
>     
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>     Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>     Link: https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile     |   1 +
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 939 +-----------------------
>  drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 452 ++++++++++++
>  drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 523 +++++++++++++
>  drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 214 ++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h |   2 +
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   3 +
>  7 files changed, 1206 insertions(+), 928 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c
> ```
> 

See Bugzilla for the full thread and attached dmesg.

Anyway, I'm adding it to regzbot to ensure that it doesn't fall through
cracks unnoticed:

#regzbot introduced: 19898ce9cf8a33 https://bugzilla.kernel.org/show_bug.cgi?id=217622
#regzbot title: dma-iommu.c:693 __iommu_dma_unmap bug trace due to 22000.c split

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217622

-- 
An old man doll... just what I always wanted! - Clara
