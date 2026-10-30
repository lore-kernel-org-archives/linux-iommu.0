Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389149;
	b=XVcBHz5bSTBYVnnSGKdEjDc4yJ/KQzANv6rxFnxNTVL9+EULhv0gJy2X7M9FPqfwElkS
	 GQUrmrrzNDCP8wyegKwUeTosRiwlpC0FutqR2iGub1H+0UdErOJa64HdA9nJclyNsj2Mm
	 1KdstyscB8WZwwyHoVXMnouD1IahsxjVwdGy4aWs6Gy2CkrOh6kBJjNEc+aMfaz3Ipy9v
	 dGwEi+sZ1yV0BrnkXfYg1qiyoLVzFHpBVzfSpm4VXcA/phiBaMMRnmSCZPNA1exyVuiv2
	 +AAmwuOxGQK5S2jghy6YFckjibKAsWYIJWRCVu1G/1FJWz4IQ6tkA97ZtBR9xIW9o5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
	b=D0+9XJcNWtTz6We4F16hJoEDpCzwJStXvwSYfOPI0UNL94gZZZ4DudmP9sIJT6RE3OrD
	 gCKj0kkRnqZQED+3ESyx0r/xvdmG01PiLgMOao7mIw0mheam2KVw3SgjgSsWkXie1ensn
	 okbozafbqQ73VKNPdYSTw6LP0vEw8D6w9K16wmokR0Eyz5l+dcaVS5S7PpihI1sevFRd8
	 +MTgmhPWj0Jm74h9Rl/S7I3ggPKE3XZ/Z0g2ik6E0MZaPdvQAO4nGFj+XJ0wm3EQIPj25
	 mRoAFSMshCfqqY0sDWzwD6GHyHz7t81HhBvtqG0JiBkKBnNNl5NtxhwRQoxLCD1rxFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5UCaYCF;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B56606A31D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 19:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B56606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5UCaYCF
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so11615ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389149; x=1793993949; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
        b=K5UCaYCFuJF9marNSkPGyDfOrq9T9F/aHiRetzh4eN+4nkQH/LdmHfNCe8y9zH6Cty
         HrRJz/JtzDRrnlrppT14lFrZ9mNKJmOQwuE4scvATo2VS77YwPofvdqffXmhcSFjQ3DO
         HVakoK4PxRY8irrVkGir+Xy3DhgMs2GcDoaU0A5+uyJ1YPQMe10fL51jdw2BV/VsW8ek
         J8lxMXwH62Sq2zNtBPpWAlqp7a84HfiHvp3wIeRPFqCDorlKsaEd9H4Vsh84ETrD8lJ3
         ye2naVZnlm1xZ6tprxRCr23iN8bSJfSl7noC5Sp3KynG87V3WP8YHIlNBlQLHfnB1QcR
         xb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389149; x=1793993949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=928MzBvfJGc3AdaD6rfLR7nqVT2HnyKwpgdCp3LF6iM=;
        b=egjTkj9ZvlS5sRiljRGkv3QcnkZBFv+br36/Swnhn9VjogHmDxq7Z0frHzRtffWxLR
         ooBJkCk7zqkZtqow1ryk/Bkc0KqNnaRoFvrkm9aMMqwJIo3PBJV+CrhJbgI92AbTrCgz
         1+NpiTJ4hC6yjsBFkyy9U11wwo8lLXaUu7t9Fqrl7MxabyJIf6kTqj/UbuM1c7pcjM3p
         sBOzuiRwwE9GUZzUlTqHkXVQ8UDZYPjkw0k+xDSPSLEqb4S0H2XR7BgWdkUAXsc1HBdS
         peIDDyJoWq/daUIpLyy35RmRFxMMuxNgYbfa3SuXDnHoEoKuirHYn+3LsVqamlFfTPgZ
         yBFw==
X-Forwarded-Encrypted: i=1; AKwUvBzcfg+Al1KF89uK+OAatwueaUXjxT4IS9XNUqKaTJ+iMwsL+rR7meCkpyy2lE7McUq+D9Uldg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKuhOm7zBexoSyYKEmv0IdjfJnmbERrevBDyPh8K78SQlPz1ZeT
	AVmOCO10DEFOMaHip5GmHi1BJPIqzqPUYKwmEW9F78EjQtGmsYE8xcCItIxrL+8S5A==
X-Gm-Gg: AYBFou2Ok22omwv6QeOjtDx+hFSd2UAYBBEq83kxldo0uz6h+7BXj3LwUj32qOAuZHh
	t+2MPgCrFlHmz0e+uhOYGPuLqCckjxjVDGLsa48c6GXhAzoAyFaU2VHXAj7rEt5yW8ztJdHnmc1
	+NMFueNko6olovBy5D+ZwyV/nb3FEFPVRM+Ec/nst0OHpusqCVm4auzeDZHInsz+268GcsrSAOd
	28ArJd1yjcP4kizeZO8Wp95VTrJF213KEnLDYNFzZljgmWh6tJTCUInwPP79gli1r6IQ2e+VMZr
	Uen1pBMClAX5EnviCnE0QVfLsA66qLvPUjcqARCrxXIfWYHA8hD5EE5rKbUOORhZexnXyBYwm4N
	QPC+vU6Etxr2YlI1cx/1bAvDEzOgIDsYMoQUbcyFFnT5MLK7I9/Ndetiiz+DGSF7594OZkCxoWM
	YUGy18jFV9LMXm0ne7Co4mbXAlXcGx7s794ZKT9LOV/Yt/wFV/3j1LvBulf6qwhPfOHnILY/ezM
	XARqkfFigkBuDmBrp6ehbkDZfwBYfznOVQjMMoii074dz1PQlo3FL78Z4UwnecnPr3VhXCTghrE
	rn0D0p5eCiLIs6XnSKLSluLkzsxYgaiXDhxGc02vB2ozU5La/VQy+wHG+whYZ7vjshfPLGlKhBw
	7m0W5IGKwcUymTogia3NW+A==
X-Received: by 2002:a17:903:1a2b:b0:2ea:7180:3abf with SMTP id d9443c01a7336-2eb019a757fmr19414385ad.15.1793389148212;
        Fri, 30 Oct 2026 12:39:08 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm9577767a91.13.2026.10.30.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:39:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:39:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 13/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <auTxXD6mztQRp2qd@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-14-skhawaja@google.com>
 <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>
 <auPC2pByvuW5uHyH@google.com>
 <84fe2789-7bbc-436e-9141-e879d2e90ef9@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84fe2789-7bbc-436e-9141-e879d2e90ef9@linux.intel.com>

On Fri, Oct 30, 2026 at 07:38:54AM +0800, Baolu Lu wrote:
>On 10/30/26 06:34, Samiullah Khawaja wrote:
>>>>diff --git a/drivers/iommu/intel/liveupdate.c 
>>>>b/drivers/iommu/intel/ liveupdate.c
>>>>index 36816d3651e6..665ebb81bd61 100644
>>>>--- a/drivers/iommu/intel/liveupdate.c
>>>>+++ b/drivers/iommu/intel/liveupdate.c
>>>>@@ -394,6 +394,137 @@ void 
>>>>intel_iommu_handle_drhd_restore_failure(struct intel_iommu 
>>>>*iommu)
>>>>               iommu->name);
>>>> }
>>>>+static void domain_detach_restored_iommu(struct dmar_domain *domain,
>>>>+                     struct intel_iommu *iommu)
>>>>+{
>>>>+    struct iommu_domain_info *info;
>>>>+
>>>>+    guard(mutex)(&iommu->did_lock);
>>>>+    info = xa_load(&domain->iommu_array, iommu->seq_id);
>>>>+    if (--info->refcnt == 0) {
>>>>+        xa_erase(&domain->iommu_array, iommu->seq_id);
>>>>+        kfree(info);
>>>>+    }
>>>
>>>This seems to be different from normal domain_detach_iommu(), which
>>>looks like this,
>>>
>>>       if (--info->refcnt == 0) {
>>>               ida_free(&iommu->domain_ida, info->did);
>>>               xa_erase(&domain->iommu_array, iommu->seq_id);
>>>               kfree(info);
>>>       }
>>>
>>>why ida_free() is skipped in the restored path?
>>
>>The restored device can be removed and probed again while the PASID and
>>context entries stay intact. So the restored did is not freed in this
>>path. Once the domain is reclaimed by the iommufd, then it takes the
>>normal detach path.
>
>Can you please add a comment to explain this?

Agreed. I will add a comment for this.
>
>Thanks,
>baolu

Thanks,
Sami
