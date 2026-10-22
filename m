Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674769;
	b=JBDDAfWKNKzZ+Il4VIf8zM7bktf3J5X4L0nTEziItlfywAZVMzSyMMA848O3zEMb5it3
	 CYyxCIQ404HH2JQ4D9ft2tuQhO7Tk//qlxogAm2k7kKvmygEWaUsIGf8qfdsa+PNofrDA
	 Vt1nbgqBqDNu0IQ1xqfTjPBcgsBWwIxsHmqlaiuaxelozLOV/cgPY0VTccfzXHmMsbs+y
	 C7y0tScMedINhtcCgwFyjWbDIH1MN2TaY5mdqUsms8XqAOSc+MwsX58wpdKsaG1bR9jNG
	 s9lbKoa8XGUfA1/LtEwKO5ZCBl3ExVxIo+4k8csgqscUcTK4LpkspnTU3iq7pmVZaJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nfYEKhh0NOwW5bByBsDPAiJ4npQywhU8FLsAEbKDB48=;
	b=RIF1FGZ7UFIEBreTowxL1ui+j3JIkqtv7WoOKypd7q3yvTcB3rGzpJKh+o/tNU/mmU2g
	 miJRpTqzI5DKiMUCoHjGAcV4QOsyudmMEFm/YsADzduygN+C83/PwhLWdvaL2xHfQFnVn
	 tsAomfkMIaeS81ITy9wUsvb6CneTJ0e7cy5VlefKePgZRZtR/ljuko6BSV/YWtR3o/swy
	 SJ5c5vl94Lae/47VK3HH3rRTOAe21p+I0KoMqCLJqg4dNzCr7jBE+XLyGi4LdOV/WXrOx
	 Fm8ifxqqwJjFgV/tiuJUdLt84PQZxij6Iau0YP+6/FsamkYOCjWwmLouVErfH6zUWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlxjVqIM;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14032606A326
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 13:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14032606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlxjVqIM
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8256106635eso975974a34.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674768; x=1793279568; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfYEKhh0NOwW5bByBsDPAiJ4npQywhU8FLsAEbKDB48=;
        b=UlxjVqIMdrqnGob8x/sXGGKL28hyViltGZKokblTP8GESw0sl/Ff+iibd58N2LFy4P
         7tlAtXOdbKI1Yw0E3e9IOb6gL0VtAtOnLL5Rr4CKYBYy1CyNAtz3IhVCr2ThaAwK3hzb
         54u7WAlgq56fxnb1ZXEAPD9sSMRXPCYxDnWMlC7WfediiAzwx+5b6Y78QWnqOovQ8qki
         sgr30CmSktukgE30dJZIZXqiXw0l7EVq+BgUOrQ7HyCZuSKyOHePXEjzV6/1cqX3a2T1
         vkDNb1usQlC7B+kIyH/kxemwbuejEhD9wa2TjTy6QRL802C02bY/DP8BCdJXAKQGJMFt
         zhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674768; x=1793279568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfYEKhh0NOwW5bByBsDPAiJ4npQywhU8FLsAEbKDB48=;
        b=oBPkwE29X+yFHJzz9TpOl8b25/1ywXSXMOZt6vE4UiPpW1+wll6mX0NpuU0WASsZqu
         5MWCVboGOG0VMBNWmT0XunaW+upALMdu78z+/pAsYhTBlaPI2AunrxmQTEI4HE2HLqOp
         2Si78bI3EnLoxl/7jAyV4Jt1gHPvAGDvkmKTzUX+Jj+MGe+W17uE8oy02/ID2rSihNVD
         7PAQPE269yy/WxGUYFm4vCi2+5rwnKQFCZVPa+YQ5BpFmheZ8L/f07mNkhMWf6BdNq1Z
         X5W+2D/4y0yQmugP0GuYX4UQKhL1xRaUCYn3sqI/Xh6fHc3ZpAjVfxMYIEah/dI1Bal6
         fQdg==
X-Forwarded-Encrypted: i=1; AKwUvByjyBVEA8Q7rUF1QLvxkAcusWJtIDZ+Ma0lDlcjvrtFaOfrBYoB+O9Kmr/RaUMUie4R3Rspbw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJsDxZmAzGWZSeorvltY5e0wpGGct/AIAxn4ceBUxBlMGAbW6m/
	w5UDGnJrX93fehyz4JULHwdO43zwMEgTNJhNYDtgZWH01bMiGRDAq+hb
X-Gm-Gg: AYBFou01Gcon3rwPxu1MgLRsQv1LLnKf3p0n6uc8Smiecra2BTn6NWHC5Kf5S1TlkMp
	dgxWS9Wa9GDk2xo//o4czIcTwQNKZXIpm+DnTEBDtZtJ+5dfCuAAaZaStgsikwzf5vbpvnRAo7t
	Sg9uvoG+tc2mdMyRawI4ZiUwW5TfoYsA+LYjhy2z0ihi7DePpbvdlesjU3xr78Tax9frTeXvFXN
	B8m7Mx4gSOjTvSc/fIQfO4QeiAPZQP1vrdrrlAWPVO2KIFAyyPfuGz6Qbp8Hmefo7A7Np8I3mkR
	n2RgfPU9gcwlnajBPk52QbMz8treFiWZySJvh0D6vB/otohLjuXRvIetXzTJNOKrYqayGvarY0i
	irgMniZ9WDXnCS76JqZ5GoLNClt3zGS+0TC/MlzPWx4BJbl78V/1t6MNSRsjzyiFH5X3KTkoXEX
	10onMaVNSfWtjTIxx+KGELqEGTWfVfVZNGcQT4blOfP6z2iZG6n1tEzjfdBWE4rLQseYSWoGC0y
	Ux4Alc/sW8fp4wiRScQIhhBUS5pgVrBVWm2K98uywN7jfBtFAdqZ8sJENj8XvCh9ptaJGxbMT35
	8wqQd8vOmXfOsnfFHnc8k4WTWfHkCQeb5dc6cQ==
X-Received: by 2002:a05:6808:30a6:b0:4b9:a88b:888e with SMTP id 5614622812f47-5535be9e63cmr3845871b6e.36.1792674768107;
        Thu, 22 Oct 2026 06:12:48 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b6da2902sm4259863b6e.11.2026.10.22.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:12:46 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH 0/2] iommu: Propagate iova_bitmap_set() errors through read_and_clear_dirty
Date: Thu, 22 Oct 2026 06:10:13 -0700
Message-ID: <20261022131015.3281745-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up series on a6ec38d74c08 ("iommufd/iova_bitmap: Fail
GET_DIRTY_BITMAP when a bitmap page cannot be pinned"), which keeps the
first iova_bitmap_set() error in the iova_bitmap so the ioctl fails. As
Jason suggested, this series propagates the error up the call chain
instead.

Patch 1 makes iova_bitmap_set() and iommu_dirty_bitmap_record() return
an error, and makes the iommupt and io-pgtable-arm dirty walkers stop on
it before clearing the IOPTE. We only clear the dirty bit after it has
been recorded in the user bitmap, which prevents a failed
GET_DIRTY_BITMAP from losing the dirty state of the IOPTEs. This should
also address the case Andrea raised for the -EPROTO path: with this
series, an entry that did not fit stays dirty for the retry.

Patch 2 adds a corresponding selftest. It fails on the current for-next
and passes with patch 1.

Tested on x86_64 in a 2 vCPU QEMU/KVM guest with the iommufd selftest
(mock iommupt domain, CONFIG_DEBUG_GENERIC_PT=y): the new test is the
only change in outcome, with no WARN in dmesg.

Samarth Narang (2):
  iommu: Return iova_bitmap_set() errors from read_and_clear_dirty
  iommufd/selftest: Test GET_DIRTY_BITMAP with an unpinnable bitmap page

 drivers/iommu/generic_pt/iommu_pt.h     | 29 +++++++++-----
 drivers/iommu/io-pgtable-arm.c          |  5 ++-
 drivers/iommu/iommufd/iova_bitmap.c     | 18 ++++++---
 include/linux/iommu.h                   | 27 ++++++++-----
 include/linux/iova_bitmap.h             |  9 +++--
 tools/testing/selftests/iommu/iommufd.c | 50 +++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 28 deletions(-)


base-commit: 04bcf84613346b973a8cc0c59238b6b5bc902688
-- 
2.53.0

