Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051B13E02B
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967508; cv=none; b=JyJu+TVwTSZ7bABnKe7+sRj2ILvKJ5TWuhAmZieyV4tTO0n7Aq2uJ08vxG7RktmDN52VpH66nZgP/d3GI2ECZkOCWmdSB9bSGfTVdBv9Mo+KMP3Cd8Zay55oWxkcuhET7Pt0AyIRUyilBlLXSF7ngIonkt5HR+irjOLm4p3Rg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967508; c=relaxed/simple;
	bh=tFp0I1ixSIGjk0J3hzcghmx70zj6H8iFP/ZPi1pOWcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZ/rYVbmEF+bjqCMhBXGjyaNTJcNe5GqZjM14kHfOPWgDrN2KSBXswIsqFCsmJXi+ruiO7Nd4Ndxr/Q5nTiCFhYpmZpM2wD+qkzcbwE2a7kPPlkARY3RQwxGYPLKn4NG7CFl42VjqpGvqMLciu6S944c1ZtQ+qSA9EoSRue3sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rntvu6OQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rntvu6OQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee13ebef37so93960035ad.2
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967506; x=1716572306; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v49Dj+gbnQvzNsVpnYNnWqEQpkDjTigYZ0uaaGS+wzY=;
        b=rntvu6OQEvcw+x1EcHcg6DKyfcA+EZR++7CDulRZpibUqWKHsQrt0H1Ef+n06RpW3j
         KnqV2l2kyP1W32YGMR/7wGxhg7LfsLOSyXuVyS24VPVEZR/ZmiLrNkldV6286Z41WoPK
         T7SJihQHiWwZ5xhSv30HSQwrud3laXU5hW1gwswXkgUMw9z4Y1XohStXJJiQhEdf/o8G
         PdaI0KlYAcHDo19fFvQ48sJ8PqxtNj1z3+g7wSDKKdnJdD/446mUSpP+ZV8Nuyfc3iXB
         UmorvToXCAWTQiMYqekeIy48cmF6RGprY4MiYviPoW6sS/EaNKmmms632e8/P4HdIJQz
         u8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967506; x=1716572306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v49Dj+gbnQvzNsVpnYNnWqEQpkDjTigYZ0uaaGS+wzY=;
        b=ROjq6DpJl1ODDFD5abfKx6HH5hcviQld67s9Zdq6tgryLu+/HPa1h4MqgcaxEfxRXm
         39/RuznV771wQIYeWCqouPdN2pBUK35knLGBdWxCP3RF1Zp2PLeHh5cbl3FECqaH0wH8
         OK9VjpLhLTnHzIpnKPhOZ0+sD3Gry9i35TTPDPtA9lWFI0VfGYH3pIcQqAa1A7NVwGTN
         uQ7poV5NgmSuVOEspH5toUhfAuszbezs7/XcBvKST4LvvILdQ1NJ1yh+FJxGtWWnliu5
         pd1xC5MHJKD6SBCC8+qqeedG1pbNrsp4WePYQKQdN1MGXV996uk4nxsfbA+BiHtTvrpN
         Ia+Q==
X-Gm-Message-State: AOJu0YwqEtJ6fxEu9WtxRB6nXmnt8Da65LtZG1bNRqoTFwjQk/koO/J1
	ftCcIoxVFhdOfZwSpwUrIMISMxHtMMLelh5KISsUez4vVM2euZRpLg6ID6jUqbNh8LhscE2/cSk
	fhHfDy+78WmIayg==
X-Google-Smtp-Source: AGHT+IHLSmcva4cfRRDrPAJHTSjD69JJ2b8EEkFLyON9XgY9LsefdYupK0M6dExJhHVXVKpOWInCESsGLA3vy1s=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:903:110d:b0:1ea:26bd:fd95 with SMTP
 id d9443c01a7336-1ef43f52f23mr5637345ad.11.1715967505898; Fri, 17 May 2024
 10:38:25 -0700 (PDT)
Date: Fri, 17 May 2024 17:38:03 +0000
In-Reply-To: <20240517173805.4181349-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240517173805.4181349-1-tjmercier@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240517173805.4181349-2-tjmercier@google.com>
Subject: [PATCH v3 2/2] doc: swiotlb: Document SWIOTLB areas parameter
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: iommu@lists.linux.dev, isaacmanjarres@google.com, robin.murphy@arm.com, 
	will@kernel.org, joro@8bytes.org, Michael Kelley <mhklinux@outlook.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") added
the ability to specify the number of SWIOTLB areas, but boot-options.rst
was not updated as part of that commit. Also adjust the swiotlb option
syntax to clarify that force and noforce are mutually exclusive.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index a37139d1752f..d54e636f91f7 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -287,9 +287,11 @@ iommu options only relevant to the AMD GART hardware IOMMU:
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
 
-    swiotlb=<slots>[,force,noforce]
+    swiotlb=[<slots>][,<areas>][, [force] | [noforce] ]
       <slots>
         Prereserve that many 2K slots for the software IO bounce buffering.
+      <areas>
+        Number of SWIOTLB areas with their own lock. Must be a power of 2.
       force
         Force all IO through the software TLB.
         Hardware IOMMU implementations can use SWIOTLB bounce buffering in
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

