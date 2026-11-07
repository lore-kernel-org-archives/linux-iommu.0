Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033258;
	b=VaGaT4CVxuFS7qGPNsnVesQG5YQ/wcO9+nAgoENxChVX43clseerUc3Sp/li8XrpOzZJ
	 J+qryEfS7JxKiQd8jXZcH0JYVN0pH+Y9nROOkzSZ1eYHVBSac/jmy13MouEZPX52GBapk
	 +OVn6F4ps7ZJb9XDWIhbaiZoubZRl5HIzTP5UPjHtaq4XTtxzn9TwNzm6Cp9RYg0KqxSU
	 R6qMhvIT3Ja4uDxGKweSB94/w/YYiFY+TE7Fr2XIhtrm9rSq/FbxM6faUuI9NoX5TRoKw
	 NDZGTBVSjMyLESyBtb+tvyFlOoiUQzYIVWcHgv6UKTKpf67lfH8BPI5xRTfNGUbxWGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To;
	bh=rCSoVSPy0ubo1scrbTANm6C4v1LOJKhrmcmQgcyDlL0=;
	b=T4dm8Jmyqakz90q5jxkHFcGNTM9bZ/oJw7qvWLtjK7ylO3v4F1QUFVj9rTdqadzH5VpU
	 GX9FZvRXsIdWFMIRKOS8S17+qNEubKwF0Y40WjIVJMzNigz9vsyiBQP4L9Aj4ZyLkhbkA
	 rcZ4fw6aff63BZUaLFQRxi/12eO2vU90pIVVmYrcs471+fB9WREVK7Gc8PTVq780aiSzm
	 2B7GGo2ZEDHWfExY1qV2Q5wPCBkkKkxXfLZldPJdBsSB21cxMCN5nRjtpptDP+7Hli80o
	 oMvOtRAuKV4AHyE3BP4aHf2CNSrhcLqZ8f6SbQthXnOunRtsD4m/HN8f9bbgf92WAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z76a1PNW;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDB606A32C
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 06:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCDB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z76a1PNW
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so514728b3a.3
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 22:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033257; x=1794638057; darn=lists.linux.dev;
        h=in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCSoVSPy0ubo1scrbTANm6C4v1LOJKhrmcmQgcyDlL0=;
        b=Z76a1PNWKXshPiMPhuGMlZPjZXYAmE83i2WG19mo14leZOOAkxXkWSAmTtyiwooiB2
         q8t1wScpujpdL54lr6mEsxpASkfGvWjxySLPc8/pJfwmygalgbWlvVNoI9Ml87p8mS0u
         k2FWNoAjtmkcEUXlaZGdsZkF9AI0ZHUkdw8gsP5DDVDMWffDT5FSQEPVmCtfjDSTGEK6
         u2M/Gnx+UTRmZJPpdDur69x4mowyaYL8opZBNhr5QAsI/nVGlsjs3PhoqDzjsWwqygXE
         y3FjX0P7RAckNtbAUvkXCPAFlQbLNxpqCDgqHZHNtf8TZxVkYAGdyfj4HUl4XdMNg0Cf
         2J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033257; x=1794638057;
        h=in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCSoVSPy0ubo1scrbTANm6C4v1LOJKhrmcmQgcyDlL0=;
        b=CV4brms0udCzCqg70evJxUUXeK6j5k1qi2VRLSQvHWmhKILEoi01fmqSExXxo2ebpa
         XXKZKtUnVI24m6AAzOllJ9EVNzSH5B0tpg58Nc/9aTg8twAxvGQB7NfciO+TyhBDa1eL
         MIdSCH6+8RnaWJLY4c1I90qspup0fKXBoQ1WKnD8j6cpEoFGKuyqBtPaXhbpLxARWU+B
         KC66Neg24tyX4qdNoI187L+zOD9TkdpZ9BPJdAtbHSd64X707SYl5bJ/q+0gMy7qe81D
         xHSWJ5ykWb4eMNqZ/iGymRzpHqSYOmefhPlU2uGvT7gtx33V/6H7HFBXch1B0qIGPRdl
         iMmw==
X-Gm-Message-State: APuU4Z++HI/KlWY0F+ClDohN8R1ZnjCTIQrbvCVOgQIRwLyYUjT+auan
	C1WTanUftR6MuXdaRlcDQtbFE8Q9uO8DAE7zVVZRYSqkHbJ4TkuY20xt4RnXuiNk
X-Gm-Gg: AYBFou2PvApLZXHxQKU3Ge8+KIa7x4zOcM0qtxLIz/Iw2xgGYbl2GeXWWpOhJ7k9tpy
	ueVcpRjl9XyDmJn3dXNPTJ/wOlPxKhV8grHJMM8c8kHPJK5JHHbqM5rf5U7caryW1l7Eznj4vjk
	UIA+zXVq1rONv4qOT0uxhHhA2qt7NGRwWqEcyiiymL0ddRrWBFqKg3ZfaYcBJ8+UwUU76yGH/3g
	dd+Pz4z8WEUe6L08YhKKQlVRo4Dq7F1Jvd9AEJxBW7OVzcSFGd2WloJo+K4lLs1ik57fcUNFSl7
	xkPwDybubztfJQ8MjuTGPFYPfYPJ2VSRTwjMVYcKdkxA6cjvro1Rydl7XuLsmY1JwAdxqD7IC5m
	9C1k0GzUkL6OQTsSuIlQGFgG08N3SGe91990US8q4Wyldq7s7sz49OV4xnL7yLttmx22SC5ab3W
	KY4TCGs8+Qe4zCCDwP8pSdzSe7b+xnTT42wHF3pDrRbet+yWWHfYivuJYQun39jBePMb+vuPrvu
	Jt1ngZuWMD2KfoN+GInxLnMy/le/dNoIX95hKOs+1H5d5LLaCURbpbMaFHsmxsP6YyvIuP7iyW1
	9AQOKH4NoMGgNjXVmMioEmU2z6V7DBMeHrFLgA==
X-Received: by 2002:a05:6a00:188b:b0:881:8b53:f64 with SMTP id d2e1a72fcca58-8b37cdf8de2mr4176428b3a.59.1794033257505;
        Fri, 06 Nov 2026 22:34:17 -0800 (PST)
Received: from [127.0.0.1] ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b359dc7805sm1149089b3a.40.2026.11.06.22.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:34:16 -0800 (PST)
From: Qing Zhang <diasyzhangqing@gmail.com>
To: iommu@lists.linux.dev
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>,
 Krystian Kaniewski <krystianmkaniewski@gmail.com>,
 Tal Zussman <tz2294@columbia.edu>, linux-kernel@vger.kernel.org,
 syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: [PATCH] iommu: Fix dev_iommu leak on mock fwspec initialization
 failure
Date: Fri, 7 Nov 2026 22:00:00 +0800
Message-ID: <20261107140000.1-1-diasyzhangqing@gmail.com>
In-Reply-To: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

If iommu_fwspec_init() fails to allocate the fwspec after allocating
dev->iommu, iommu_mock_device_add() returns without freeing dev->iommu.
The mock device was never registered, so the normal IOMMU cleanup path
does not run, and releasing the mock device leaves dev_iommu leaked.

Clean up in iommu_mock_device_add() while holding iommu_probe_device_lock.
Only free dev->iommu if this call allocated it, preserving any pre-existing
object. Check for NULL since initialization can fail before allocation.

Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
Reported-by: syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fe84fc6a684e0beb86e2
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
---
This was previously sent on Nov 3 through syzbot's forwarding to this
thread, after the direct submission to the list bounced. Resending.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..207241a553b9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -379,10 +379,14 @@ EXPORT_SYMBOL_GPL(iommu_device_register_bus);

 int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu)
 {
+	bool dev_iommu_present;
 	int rc;

 	mutex_lock(&iommu_probe_device_lock);
+	dev_iommu_present = dev->iommu;
 	rc = iommu_fwspec_init(dev, iommu->fwnode);
+	if (rc && !dev_iommu_present && dev->iommu)
+		dev_iommu_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);

 	if (rc)
--
2.43.7
