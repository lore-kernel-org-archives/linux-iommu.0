Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118079;
	b=MYaYcLPFYX0cK2nXDR1agVVFe6Uxg7Zjwj0XrRaVsO6/MDICkQ0XVdFr7bDzDt5YGEar
	 2m9ALkGITRmLJY0i+JyDrnqkRvZlJOlYN700RIhwoiPUETN9Fm/m1L+n/M0WwQgrMdv/J
	 y6PM4sfw5rg8oht8Fr52oIw8xmTP9zh8SBzCP1OZRsFjAPumsTXvRZQr99Xm5RGsRztJZ
	 NkZuofihc7mYUDJuKwREKGohr/V9ggvsg9g8dWfxGKuRacGrM0pDZM8pf7vKptVSEsHbW
	 hXEhadV+hbHIVo/bxvYbwevuwJS0yzlZAc4tj46F4DJcj82XKIXSTinQn/NvhIRowfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
	b=0ASErZSI96H1pNALbZSff6QE5VFeNP8u02vUWMAy1juTwMz8u/FSXUmaEtTUntA9RF9J
	 UDUwtYLRw6KdTIAp55fAOHbXQJnd5nvF2xT8yFyk9KsMKzyUS0dTFRWpeebgRN3DWxqc5
	 3lmhblgVi7UN8z7EhPIIrykUnh0RHOgwbK3JfPYQcwhFajJM4J5FtT9ONFzeBPb6l0Xn3
	 +OtVJ7K0suxFH/gxg6VKzgTvmIepBphjyMyhyOwEkiJ6WoLvWooeUOVpFu1mju8j+hPrD
	 BHQ9ZijEgmsZgROsDIDarZhLe/O/OlT+ZB+rnn2f9curd64CLaJaYuxjeZKj7Cu/RVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=AYt4HOng;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10441606A31F
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 16:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10441606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=AYt4HOng
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso49709e0c.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793118078; x=1793722878; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=AYt4HOngVxNRuziUc5eETee/POomosZg2eyvit3/Vqmo5Bum2IkaGIgYhAAq7zaPxm
         Ddt3t90M/lPh4hAYjVwWxfRXNOV4OcSTWzMjwHfOIirN8uLs8u8dG42G4aaO4nHTD4Kb
         ujsycqAEAu5zHRWBkROMFIOa2Fk0e9thLmDnXwJcMAgRi09TspuCPjv/QWVegQHPEIPQ
         rCYxnfxvfXj0fAjw++W7np1snx9ECuQ9B6EilhmfjNAgrk+lvxyjkS0zV6aXY/mAfVtR
         45Lc6W+a4mJIdPKt7xmeaCFXfKjESWBb0zfWWlCD+pUdhnbrrKKj0p0p0ciwQHIbSH3N
         5Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118078; x=1793722878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=vsTFtTU6keh3L5iSskJsDKeOpOZtREdCO+KijWRBqroUdiK+fZqCnYAKpwh55E1mfS
         jykXdsoyz90kl6+fPHZndL9OHw216P3k948rplnt2G3a8CvX9xtcFGQ+f195uOeUkXbP
         sYjSSIXVPr70aIErAN4y4d+GyI7QTlBNFIGFFMugvaynyfGplcVSlQbKDKrX5h2mcQHo
         Lqg/MOT1gPjh7vtzAs/sBIxJ+Q9DSBcoShszTptyj8vO3oq2lj6PWvjgDajhC1J5VC2+
         0Qo+P1jtFQMU66erRu/piiPsD07v/QJmgYh6C2b5T5HVr+vqvYuJT1/WhbyB4wowo6wz
         7nsg==
X-Forwarded-Encrypted: i=1; AKwUvBzl0ShgiT63DmAE/C7d8L+ega+4L06qPOPsVhtHGrDiiFypktpuye4Q/U7zTM75BB/WPIIYIg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLz8H4/qmpBxBUAY1y0y0iqoBGaIXbo7AXmMQ0doOnF/mtsfczx
	irj0gKez50uEIkp8tON0V2xcv2IGulTVQZbj960FEbCKwqVPB8fgcYOpdg9EQ/OK5Wo=
X-Gm-Gg: AYBFou1rDQPsoFi490owkE/6sJD5oZsh5XfcEL8p2IALtcJA9XpD+YavVEDNqRK/RL4
	e8ANu8kEAfH+ENXqQmC1buO9H6ewRGRrC0yOX8gZu3oF4KarhdpH4834xlDD4Rvj3/xH0jAYvGT
	cBBep8KxmySGygFGtmp3OTtEvD7pa55D98z6JuhR1zTulFp1pvh9EfYtyY8pObnjRIPVOb4s5oG
	icTpqB26hBHNsY2GHCQP9tBYs1JAW7uvbs2QCn+9dXx9XBylCOEfHyTJIcmWUCm9CMaenN1u7xk
	r7hvNd12rMnhaGJuROv3ne/OiBXPNHf/WkWf0F3NHii9eM+BvNfwFj/ZQvhoK/HP971ZvhjlmBp
	TlYGPs43gA8AahMoUxXf1WRtfs3GT9+DWROQzjlFPDQYG3CDuNNWh9BJKt6tv20qCXmga2MyGZT
	flXrIOUNOZ6qPMySqb2SymlPpf+pMlBb/YeXfCxlCB273XwUognJb5C+r2CYVAWPXg+V85FpweA
	vY+8ACnr78E5enhqeLMQtQEiI4g8ka0OSOp+1BdpOoX2NLeF7An2Ix+Eu6oO8XTdmE9p15/BGKa
	+xY02VKomKsP7ik6rQnLht2D/enJNOtQ2Wg2RtvvpE2RGSOHyiAxPo55x7O/v6rXI52AESdLDw+
	cZrA/FySRtJ5rzQQ+BAhMu1K6DitPag==
X-Received: by 2002:a05:6122:1352:b0:5c9:c60e:3a40 with SMTP id 71dfb90a1353d-5ec232e48ecmr4515149e0c.18.1793118073126;
        Tue, 27 Oct 2026 09:21:13 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4a5f26c7sm304662e0c.9.2026.10.27.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:21:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:21:11 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDPd6tjzACQVszf@google.com>
References: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
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
In-Reply-To: <at-8vkVpN2SF3XgB@google.com>

On 10-26 20:49, David Matlack wrote:
> I still think it's not advisable to define name##_wrap since anyone
> could accidentally start using it on the incoming path and we wouldn't
> notice at first (especially since same kernel Live Update tests would
> keep working totally fine). I also don't think asserting the combined
> size buys us anything. The header size is just a function of the
> number of features, and what we are trying to protect against is
> structs embedded in the payload changing size.

Fair point.

> 
> So I would just do:
> 
>   /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
>   #define DECLARE_KHO_SER(name, payload_size) \
>           static_assert(sizeof(struct name) == (payload_size))
> 
>   DECLARE_KHO_SER(luo_memfd_ser, 16);

My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
must be enforced by the compiler rather than being just a bare 
static_assert() that someone could forget to add. Since kho/abi/ headers 
contain both versioned structs and unversioned sub-structs, it must be 
mandatory to declare versioned structs in kho/abi/ with their 
static_assert size check before the kho_ser_*() helpers can be used on 
them.

So, how about adding enum names like this, that are going to be required 
in accessor functions later:

#define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
    static_assert(sizeof(struct name) == (payload_size),          \
                  "struct " #name " size mismatch");              \
    enum {                                                        \
        __KHO_SER_SIZE_##name = (payload_size),                   \
        __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
    }

> Plus helpers that allocate and initialize the header and return the
> payload as a typed pointer. Both the outgoing and incoming paths find
> the payload the same way, by computing its offset from the header,
> rather than through a struct with a fixed payload offset:
> 
>   /* outgoing */
>   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
>   /* incoming */
>   hdr = phys_to_virt(args->serialized_data);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);

These would become, where without enum, the init would fail:

#define kho_ser_init(buf, name)                                     \
      __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
                          __KHO_SER_NR_FEATS_##name)

And payload can also check the existance of DECLARE_KHO_SER, using 
(expr1, expr2):

#define kho_ser_payload(hdr, name)                                  \
      ((void)__KHO_SER_SIZE_##name,                                 \
       (struct name *)__kho_ser_payload(hdr))

We can also add an optional kho_ser_alloc(name) to allocate, init, and 
preserve.
