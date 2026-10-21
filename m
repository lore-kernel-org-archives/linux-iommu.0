Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626948;
	b=v01wis6S5if8snQPXaqsrxX5yWqyVQKpnafM5hGIlQRCxg5CTIfZANIIQEndZZ6vl/j3
	 hSHNn0yPdM2jy7v/rY/yvQSySDCo8bvWo6ab5bmKvRGvVV+w6gs+h2UmEjsnqMWD1ZCeu
	 Tpwls5UVAwK5bW74ANp/yoMNAMlxp0fcqT++nB7/2jPShfFAjc5H66wMiJz7tokBrclR+
	 hNxsXemU43BYAyNKF+8utF4CJIPIygnQumR8Kv046vpwhBt16X8QaxlGjxsUTNLbhm2OG
	 GW5NJUiObGwWjib92gCQ/b/H7wW8jePNA9eH22DuHNY99SHXwARmHucumXswjKpI70Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
	b=fcbTiwGGiqWNU5p9dzPX2vCHbTLdIIx1IHVGspKsdJWRVqu8LKmEnHImUqtUQ7HMtncX
	 6HoB2n9rZd0am1RVH7gGtTFoJnEAre7rD4eguYMbr+yVdmUqvfpYe2Wc4CS4EUQxXPvdR
	 kZrL2yLoxkSXx5DZqw+/YcaJOfBc8Nn42fl1d9YxKHMGBK8de+Mamxqy4GMHvdHwfcPOk
	 XrjHaBqRg79MwnADda9SZ0SIXAhDT9ZCaHYaHIfKrbWPfLFwRRorCE8LcMU8AjqiIySnw
	 wsbs+m1zblC54rzijv15t8Fi31x/z1stJAy4Kyr8CGQYlxbOHzfdsDWO+fF5wbSQPaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L+vnhoHf;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2F606A319
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 23:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB2F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L+vnhoHf
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16aedso7522705ad.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626947; x=1793231747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=L+vnhoHf4ZKWO8AQ7qVKnrKcbki85jfVHirWnaua2gVXYYcjUk3gBL1rTemxDZMA+P
         L6C3Gx7+GdHTQ7AiozC49aSHM8FcdVhFzwlQyiHJKQvrFyapKkZ8Z6hrOvYFpKFyDlWo
         9Q9gVE/PJ33cMNe+ev7wOb/rFH62es23e1wuaBL2ZYApo5sBm9eVZuQsGudZgv0zsmjU
         BXBYOD3LFPpX+0JPTLQcmKse9fIwU16Skud49P9BSK+g5zq552ZptBMtzi1KWFUJJuN+
         ruOvH3CN2xCVERdNpOeeclXsXmHPr990DuCTYAIi/oMHTtuCGDqiho4QkcaZ5/1mKn6I
         eAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626947; x=1793231747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=Q5h2BkCN0Z6sDEiamhQGBJP3/vQK67oHG+JnXbHSEh09hwvhNojMnSRPAErT8FxwWb
         hxsMoRSXltp5ZWFReILEFDs/hkfsBWsYX/VuYnCII6UsYIzkSuNHkVr+XuztVT4zKH5V
         u4WuCgam2B8zhYW8WZY9jfv3PFZQyiRZgM3kKvhOyCIoo6iRww5GXtQWgbXQdSX4wy97
         gbxhiDemoHzyVAp6jlrvKSbDguc5F3kcluaiPhm30bF+NVitZAYWBp+0IGjXcHFmqzLc
         oveOVqEbpviW/zs20pgwRG1GsRIw3bivkvMy+10wA3Q7odeM2CZeNVNFvp4fYxOqjUfR
         wNug==
X-Forwarded-Encrypted: i=1; AKwUvBzwxZ811K0wWio8a8dwpU1lrzxXbDx+JCCzJIwJefdqkdDCTDAcv5/wwQHyiSfoJ6w1gNA4gw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKyBYLZkwwjVPv52RY7UKPK2qQj9xqOfCCl+38u0y1zzVOnaUqI
	XUAk7SJibIuGmjf9OzeBudw+9/0K+nKzpGnALXW6oy75E5iBJyew4tymSNXXtd/RQg==
X-Gm-Gg: AYBFou0FpAY6Fd0NfjsrNVaW7dL4jyXJaoLKaeLWAwIxV/IkG8nuabm1yDbgJCk7SmL
	6awP54NZnaQH54C1BszeY24zPedzK8jKPP/k++hpAIMy+riFoe0nLI5iU0+qdi9PyKIWyP1g0pO
	uuQgeUbMbZ3U+Tc09pN3J0OPHjHtOlQo2NEzBe3Ie3+wJTn44h4Vho0Gzv8KgkLM8PXjI+ykTSD
	TXP7bIBOKChe+pWfBUoJB2eqT/6oY9v2Cvza00DXIv+L+2fB1T6hOGMogMn8ehZUY5uDuLEpH3o
	IPKvxK5povGt3Mldc/VmF/o+HxfBj8bKuaE3PSlZmVBARkP1+4CMs3IjeI+EV//yKm/+hVdPlTj
	00RcK6DZt5TefNLmue4QCQcClrMQrhKbT4deBHe14qIZXqWebdIvpHmC7yxMPnW0+CI66Qdebor
	9crYjSZqm9Ejw1aLnkDcGmDoU+a8zEgEGzx6sgPozptdP4ltO+uoqSYdwTEDWtuKM0WWICoDYK7
	ftm+kmXUusZ+Df8XPtD8AygWLJKeCs4Ery5YBllOIze2hs/T6AAKcqz3jGijxJXMXRhcjuW4Dyo
	qbtLpXMaw9bpcJ4Q
X-Received: by 2002:a17:902:f70d:b0:2e8:3190:73a with SMTP id d9443c01a7336-2ea44075412mr31011645ad.58.1792626946744;
        Wed, 21 Oct 2026 16:55:46 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b30829csm16784705ad.11.2026.10.21.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:55:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:55:40 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlQ_Er0Ig7CCSxv@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>

On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
> 
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
> 
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] = 0b11 chain to the next entry (465
> features in total). Each subsystem defines its feature states as a
> static const u8 array indexed by its feature enum, which
> luo_feature_hdr_init() packs into 64-bit flags entries with
> LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header from
> the source kernel against its own feature array via
> luo_feature_hdr_validate() according to the per-feature (req, active)
> truth table:
> 
>   Source Target Action
>   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
>   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>   (0,0)  (0,0)  Accept: feature absent
>   (0,0)  (0,1)  Accept: feature absent
>   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>   (0,1)  (0,0)  Accept: ignore payload data
>   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>   (x,1)  (x,1)  Accept: use payload data

I think we have different definitions of "required".

In the PCI series [1], required and optional flags describe the _data_
the previous kernel handed over, not the kernel itself. A required bit
means "this preserved state depends on feature X; a kernel that does
not understand X must not take it over". An optional bit means "the
data for X is here, but you can safely ignore it". The source kernel
only sets a bit when the preserved state actually uses the feature.

It's up to the FLB/FH retrieve how to handle the scenario where a
required bit is set that the target kernel does not understand. For the
PCI FLB we panic since failing to adopt the PCI state could lead to
memory corruption as preserved devices can be doing DMA.

The target kernel never requires anything from the source. If a
feature is absent, the target kernel must handle that, e.g. by
falling back to default behavior. If it can't, that is a compatibility
break and should be handled by the compatible string.

In this patch each kernel has a single static feature array that is used
both to generate the header and to validate the incoming header.  So if
kernel N marks a new feature X as required (so that older kernels reject
data they cannot understand), then kernel N will also reject every
kernel that does not have X, because of the (0,0) -> (1,1) row in the
truth table. That breaks forward updates from N-1 to N, and rollbacks
from N to N-1 even when **nothing being preserved uses X**. Therefore,
every new required feature becomes a compatible string bump.

I would drop the target-side required state entirely and let the source
kernel decide which flags to set for each Live Update based on what is
_actually_ preserved. Accessing a field added after the original struct
then always requires checking its flag.

At the end of the day it is up to userspace to never start using a
required feature while they can still rollback to a kernel that does not
support it. Cloud Providers know how to do this since Live Migration has
the same problem. This also means we must be very careful when adding
new required features, as they need some way for userspace to explicitly
opt-into them. I do _not_ think we should try to have some generic LUO
opt-in for required features. That is up to the File Handlers and FLBs,
as they have their own uAPI.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
