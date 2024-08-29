Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920C14600C;
	Thu, 29 Aug 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915313; cv=none; b=Ivn56OlYUr+0zt+0iMef/JE83oaaL4eo40XjqwQT1udypgZrAHllkysMewdOKVQEY4LMi9aWw+9kZtlRCDrjj7iuATLqg+JXdbRayTojU+GDYXVNDE9lRpgEvCc/GIf3O/C+HgnWRerGPhreB67LFDSCpmMkkVPfQ0ruXV8sU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915313; c=relaxed/simple;
	bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGRoaPiE9awtG5/9ba2xTI6dfH4KxSX+9YlvUKszSPy2xESPc6ENPKy5L94Aygg+qp/AErQrPgvQuNoAlXW8s9C4oL88roMg2eakSgDfpUB4gpUp1uuHNZRFeh5TczDds2NhhLwA6/yNv6ndh9iFFPkpraKmtKE7qkb+tIRod9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpaX9S+X; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpaX9S+X"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b3afc6cd01so11785327b3.1;
        Thu, 29 Aug 2024 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724915311; x=1725520111; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
        b=lpaX9S+X3VlkK+8l0+brcs33cfOJtUDBD/pN1UUBSY6YoHV3nr+yFmLzXsdDH8e4Gh
         cwVkbaCyi/2uobkwDzQyFZXZ07INFKEL4ms5+rg8lD+P7gT0GXOWa421J8imy5BACUw7
         zfvsppaxN7tWSY2WfpbHD/ZLvNAoRxtS5yhrPXYiEbdigT4/1X/Ru0zuIAjWb3ur7Yl6
         3sAOLjnrTHoMMHyPEXGIuMav1CrWHnXQavSeGmZ0UcXOW4INtpzz4XfyIdZeRg6YhvB7
         dp9NPcaHeCb8tFXifIc4cXRiW4XMD1vhUpWutUJqoB1TJ9YQ3qjz3sNI6Lf/puCuSgfu
         poqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915311; x=1725520111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyAuhBUMpYrYzg9Rg/bUmtSrNRyiuw2WIh1lFBFmEwg=;
        b=Q7BnK92FM9Ln4s/HAvsiqxVB6TAch4xJ56mTAbttvq52pkSdVDyCVrjQd+8XdNxY2t
         +zyFRthNRKzgyjziNKKpXsSDIc2DS+zmqgb18HrE0u/+tx3JUXVIReCD9DERJeqmHhtx
         How/co1ENCdPZ/R33jJUURY1VP7IjteDe+B61MY5J7ii8ar7F1n6sHXQlo2Kzc1A6Kzk
         pYVyCuhMxZvCrrL8Iqj6chGfv2TLgdMGAfE8jWFOv9SEyf+EY+bfVKdir/Z8NOivcGul
         +gGBT9mGi5L2xI9uWdqFxNALEPxdOLVRnaq1a5jWFbyt4k/FXySuWRbYKs421fiQvncE
         zH2w==
X-Forwarded-Encrypted: i=1; AJvYcCW4rJVEWlx3uzrwUoC7F4f5oFZMOpkzFEz0NZKUBjFbUwYJopZNHTVBfnmOb6qyHEAcZ9PyDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxElNjJolLVN0ghh2AXluNa02nJ2hURQe9Sp+6+zRMhi1WGFo+d
	MmLpQtOK/2xVpAFuMvVhoR1yW/5/tSYeORvMHZjjBTtiPrHEvshaAe3zWFq9H473NhvmL/8VCkA
	y4oDmI5BZvKEfzhOfYKMWKeBhE+M=
X-Google-Smtp-Source: AGHT+IHBG54kcyJNao2S8e3RZf5s1k+UvHDbQfTQZBYaZtFW8uvd8xnYVaG4KN2Krr/p0slYw316fyXauQdT/GHO33s=
X-Received: by 2002:a05:690c:d83:b0:640:aec2:101c with SMTP id
 00721157ae682-6d2ed2992b6mr3916147b3.2.1724915310875; Thu, 29 Aug 2024
 00:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
In-Reply-To: <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:08:18 +0200
Message-ID: <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

I did a git reset to 2b989ab9bc89b29dd4b5509408b8fa42337eda56
Build and tested the kernel.

This seems to be a good commit.

So, the first bad commit on my side seems to be
f90584f4beb84211c4d21b319cc13f391fe9f3c2
