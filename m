Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EB1DE894
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373739; cv=none; b=M8Cbvl9U8VkNE+6XN3EbVqqwJPpoOYE6W0t1QjUxXBDFxJ/nvnjMEOG0UDEWBE2zdZg0q6udyBultN6/oy6TbLKDb5+G9zymq3PiXoT69Ru8Pplj362sQi0KGwSHSGP2AUZuPAHE/rg3X/V0NgJgwtXlSg/DPufLSzNYpgsMYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373739; c=relaxed/simple;
	bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sQGAttuVDjXo12ztPTd0ePee/qNdEA7X42BKypckmjQF2PHE2iRkrZSvZzAL2fPZsJOSI+GJaE34J9ZlBjNmNUYLIXpynxiV5KA1JbDWLx3XrUcmYDgSEPP6uI80ZqxsVdvfqeUNMXb3j0YlU9OMO3F810uVz8iaWImgrSmLtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFB4n62y; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFB4n62y"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e284844d5fso282546a91.1
        for <iommu@lists.linux.dev>; Tue, 08 Oct 2024 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728373737; x=1728978537; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
        b=EFB4n62yycVqXIPtx0TllWMoe83ES8BJ91XwDQ7ekZBuBilj/dkDybDWzGQ7OqBZxL
         20EKEZMRypEvnFGhckum0lMiwsi5psCUyXKnFX8nATaEi2fvoKDLjAR+0weGf6vQq46a
         j2DJAHjYnTg8gE7sLZnmKpkt1bsJgy/W4KwD5GVNpkMVh+cr4DrLTE0ZvwuhaEyHsxvb
         YVV9Ms0jXh59leUKDzEmDzzRwR2wis+fPN1LCqcKXi8gvgQadKnFshfIM7ferZ3SPbsq
         1rNzvQL3JIMu/e65DrghHRDmFxs2RdwLVGy1UtOIHKuCfGkSeVR/c8QZCxtEp1X4o8a8
         cyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373737; x=1728978537;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
        b=plgjnf8cHO49DzGRcnSOvOKC/szf362pg7l0gdskfmc0QXLAoqecPEqFyS0q4o1b98
         sKMDpMouqJlg5ouTWGAedEcfCK6fmYqpzRo/DfC18b2uwPqAY9tVqlrzJnVnMHl+zcBf
         /S5ZOL66W4Fet4GgbFBObqnCzTtYjHsMepxfFJYj6e0lnkO6Zr+Kv1MHbwaj27/7VcSM
         Lt43F02TJTA70KnBjY53Yiz/7FlYQMLVh/Vifq0vhv8JXWOCifBQg1l4Z5Jzbj/14Im7
         qM7w6O7pfjrz/qXeJt7gFHjPss/8aM2zfSifC6h/eIyzmdoqNktb83IGQ1LanQF0ytNW
         O6fg==
X-Forwarded-Encrypted: i=1; AJvYcCV7gg0MLcjobp7pbhB57kwDeHF+s/mfLa32+JWULJz0j/XrGOilHQ1Yb6ORJSRr3TTqLcUQEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLY3MQjaXjYx2Y0enxk6+7JdpaTOuMHZNI8yP+zxs6t6riUxKV
	/OrtK9rcIhDXBZX75JXBTCje0NDNrPY/++vCbhTEMwvC9aWcEt5D
X-Google-Smtp-Source: AGHT+IErgU2lhExs25qWrVDEDDHSGx9Xkj/N08LVXzRxU9AH6TiBRcn+BcRRKUGwzhdRig6cMz2MRQ==
X-Received: by 2002:a17:90b:315:b0:2e2:8d33:f7a8 with SMTP id 98e67ed59e1d1-2e28d33f84emr423120a91.7.1728373737424;
        Tue, 08 Oct 2024 00:48:57 -0700 (PDT)
Received: from TYZPR04MB5973.apcprd04.prod.outlook.com ([2603:1046:c09:1962::5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85da3f0sm8511251a91.30.2024.10.08.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:48:57 -0700 (PDT)
From: xiebo bo <xiebohao1234@gmail.com>
To: "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>
CC: "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "apatel@ventanamicro.com"
	<apatel@ventanamicro.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux@rivosinc.com" <linux@rivosinc.com>, "mick@ics.forth.gr"
	<mick@ics.forth.gr>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"seb@rivosinc.com" <seb@rivosinc.com>, "sunilvl@ventanamicro.com"
	<sunilvl@ventanamicro.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v7 0/7] Linux RISC-V IOMMU Support
Thread-Topic: [PATCH v7 0/7] Linux RISC-V IOMMU Support
Thread-Index: AQHbGVZ6glD/G7fCRUu+7C/pNa2TDA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 8 Oct 2024 07:48:52 +0000
Message-ID:
	<TYZPR04MB5973A5633B25CA29FC81AAE1AD7E2@TYZPR04MB5973.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

SGkgYWxsLApJIGhvcGUgdGhpcyBlbWFpbCBmaW5kcyB5b3Ugd2VsbC4KCkkgaGF2ZSBhIHF1ZXN0
aW9uIHJlZ2FyZGluZyB0aGUgcHJvY2VzcyBvZiB1cGRhdGluZyBwYWdlIHRhYmxlIGVudHJpZXMg
KFBURSkgaW4gdGhlIHN5c3RlbS4gU3BlY2lmaWNhbGx5LCBpZiB0aGVyZSBhcmUgb25nb2luZyBh
Y2Nlc3NlcyB0byBhIFBURSB0aGF0IGlzIG5vdCB5ZXQgcHJlc2VudCBpbiB0aGUgSU9UTEIsIGFu
ZCB0aGUgUFRFIGlzIHVwZGF0ZWQgd2hpbGUgdGhlc2UgYWNjZXNzZXMgYXJlIHN0aWxsIGluIHBy
b2dyZXNzLCB0aGVyZSBjb3VsZCBiZSBhIHNjZW5hcmlvIHdoZXJlIHRoZSBzeXN0ZW0gZXhwZWN0
cyB0byByZXRyaWV2ZSB0aGUgb2xkIFBURSB2YWx1ZSBidXQgaW5zdGVhZCByZXRyaWV2ZXMgdGhl
IG5ldyBvbmUsIHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gdHJhbnNsYXRpb24gZXJyb3JzLgoKSG93
ZXZlciwgSSBoYXZlIG5vdCBzZWVuIGFueSBtZW1vcnkgYmFycmllcnMgb3IgbG9jayBvcGVyYXRp
b25zIGluIHRoZSBjb2RlIHRvIGVuc3VyZSBwcm9wZXIgc3luY2hyb25pemF0aW9uIGR1cmluZyBQ
VEUgdXBkYXRlcy4gQ291bGQgdGhpcyBjYXVzZSBhbnkgaXNzdWVzIHdpdGggdGhlIHRyYW5zbGF0
aW9uIHByb2Nlc3M/CgpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSwgYW5kIEkgbG9vayBmb3J3YXJk
IHRvIHlvdXIgaW5zaWdodHMgb24gdGhpcyBtYXR0ZXIuCgpCZXN0IHJlZ2FyZHM=
