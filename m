Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2191C84C6
	for <iommu@lists.linux.dev>; Sat, 11 Oct 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152508; cv=none; b=LldueKPkf3+qBHBrc5NX/TikEVEoXZvGvPzY+WiBj871I1vJjr3ezsaecCGJfoIx66OWHB4sEC5Mz7qastHRuZfxVgo33FPqHZwJ8dgqjeqyI2XBwBbRrH0imW1/NAatCxEykqVNitQbfOvhoaXVNfaUaCbs3wg0WGeXinC/syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152508; c=relaxed/simple;
	bh=VgRc1HSUo/GGyelxPOPx/dvYNds7xqzzw1DHBYUoj/c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gSRpKbSkfXKAfBregk6lTnf2c+SnemY2bcgCAXjp8hvPq8vkCc6srahXTr1/EJ/o/BGShBAocW1DLkznxO+dEB8YPOY9S9kPktvUZjUoqQGy2i9yWnNlssrLsWjydfra+ILqWiOUmu2tSjViBZYCoPTAf76bMDXxv3tHXGh8XP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kyxeOS+r; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kyxeOS+r"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b550a522a49so2199839a12.2
        for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760152506; x=1760757306; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzkBY0PBFsLQsNCmiEa3AufeeUbE2KtfHbRsNCZScNU=;
        b=kyxeOS+rxHXphZ0/NDLdaXBp4gSZmRCJQz26A8fcMIrklWgh4g6bZYLWcJhitgvns3
         FQSNxSlyiiDKOTGx4IWZ4vxDt3do8wQDy7FcxwrANOP4y1MH37T1MOKa6Rpm9plC2PwA
         EJq8G3pEbt6ju/hMF2hy5+bc0VgFQdjKUasoBxQn71xZMtTSpGkNwvqE0NZ/yPupz36i
         N2szkBp7jGDcgfNLSkhU5j0/8rD1scOfUYokMhu7YwNZ2QH43iIGvZk62nuFTQY/pjpW
         KjhumtgIssxlO1RFUo2v+6IaK++rUlh1ajs/ganqFn5Qx9vrSZVK9XPCCSyyNTpWVgnA
         jMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152506; x=1760757306;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzkBY0PBFsLQsNCmiEa3AufeeUbE2KtfHbRsNCZScNU=;
        b=lAvwbzbrBVJnrlh0xeL3byR5roU/yCNs2Glvt1B8kPimy7BPl166ntE3/RLAVlIi2N
         fENHUv6AvC0hfAXTrR0YDWjDbMB6DuAA8lpgH1HrOEPny8hTEMnVRYmHQxgdo6CCzL+V
         bt/c89Mn3s7gzxzd6NeysFHq25eFkFTSptO8o700HIlFLc7P5LzM0F0indVGF4O5/jqn
         zNARa5Xyi1bgti7Gxtyw2YIRJepAKe4IKc0MpeeKFuz/E04p5SzG9H1rW05DLhe1b08U
         E+DhuH175Vapc+luwMuBTFMxkh4P/OH7CGzlzOt2CfJUQYGulMxL+Q8MBgJtPhj0fk56
         sYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUGj2rZxzZ9xmx5D01DgwH6/Un4O+kIwmxmWzT6w11EsD4u/6lEpaGTy/+dUhauJDE36i65iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjAa7g3Lj8L3ZwbnXcbDd8FPp3/1/IvXkeRD5Zwz4oAulXSvzK
	n4Ie1vLPIV3vZ6TWeZD4UJYh2h8IGWtNzHieaj9QgVxIEQAubjRnkaWYWRQdzF/8a3U=
X-Gm-Gg: ASbGncsXUXs8f5V6sZNao3q3M7tBvE7L1t4WH6PkxLEtJmbTjinVZXafXCrbOh2T/5u
	Dzu6blwcgltKxMETfd9PbhnLfgmXsGMOzZI/18TOZzbNzffEwAuzzv9rNbPwF1kFSD1VNiiI3VY
	uM+vQy6Sa6cN3fnD4awMimu+O/c9RUVw3ZSlJdmwMx39HU17UE8xPVmkBtP5rSAPENzaJlNuUOT
	rm3ES5u7CZ41lYOPtMCyDD6kdma7HcX+x7MboU68PHaDQAzd/5SDYEGRn8+PJADSXQ21hrcqTGE
	exsf8Cy3hYWMn038JzL/0KF/DZZgScoyopUqzXjAfAGyWlMzao8VTAx4XihPHjKBbel9z9KM9NG
	yQ65ldNy/3p7Z1+JlZrm0lK26R39K4FRRZuaPICzxTCFviXK9iyyxqUGVJhBgirxMjooXtywF0h
	2JhwviGS4=
X-Google-Smtp-Source: AGHT+IHHjgXbpYOhl8Tft2FvsCqOzsuJfl2ZGri0jE7siTM5jH20pQ4uTxhaMN3qUY1IfRSVHqZPXQ==
X-Received: by 2002:a05:6a20:7348:b0:2c7:55a3:6168 with SMTP id adf61e73a8af0-32da83de308mr18596310637.30.1760152505897;
        Fri, 10 Oct 2025 20:15:05 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6792f508c6sm3496863a12.24.2025.10.10.20.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 20:15:05 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is
Date: Sat, 11 Oct 2025 11:14:47 +0800
Message-Id: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Hi all,

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

[This text serves solely as the patch changelog.]

Thanks,
Jinhui

---
v1: https://lore.kernel.org/all/20250928075257.1542-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Suravee):
 - Drop the amd_iommu_force_enable check; it's only used
   to skip a workaround in the same function.

Jinhui Guo (1):
  iommu/amd: Enable PCIe ACS only if AMD IOMMU is on

 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1

