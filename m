Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590837;
	b=GH7OapMMPwYCZMQB21bM+nWLg6s3e7Prg4gRMLR4LSwDPYw5YxSBsa8X702XYqjDJmAL
	 NNJCS7ZDSuk35LqubaJaZ/A+iQYAAggCBBzyddLf9Q1TkHxmuoY4bJAP6MSdwydXzdl0k
	 PmGkQCjyv4ggF5x5B8Vye/a+zowccvmBlWXL+FjI+THcp7jRI3D3uc7s97tRZ0gHvN3mr
	 2lWosAPdIt2GGhPWQZASvGYnVP2zMBp+mGhYdjLhj9G1YwKgsTTDTYYwz5Xr1gAU3sQL5
	 UuIGUuvanLR4KlXWEAqt/OYiILTLWGvdMoPv2+0Rt+cHU1XTFHvUoedbL8toOEx3fRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
	b=RBu8nT0+cMOsDT8zBLaWs5+0TW1bgmAiYBCGb6dvovLWwYwJH7td2Ygn7Zueo76CkOof
	 jHzL2sxrtmoSLQ0XQ858ZnVqBoxdK4Bn4fGjXZxffifAlU5iddppdxlLtjwKdEI9wHL30
	 qjM+uRcsQO6NfZGQ4FmtAydUoWHmOc3KEsqNFRAM895x4IOq51EveM269b4WSPmBeys+m
	 G1vC3faSgl+zH2hxTKVsjbHkMEuXEyev1N5m9HinIye8BJDa2vSf0WxEl7u+L91HhtCfq
	 yonzU3mCgT/f+K6EeFQhtxk/FRfnMnofM40z6W129RXbc6pCYfmUoXfkXM6lZUwNTMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lh7y+1d+;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF0606A329
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCF0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lh7y+1d+
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab43af5e97so8649677b3.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792590836; x=1793195636; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
        b=Lh7y+1d+OgKKwx4Y2G2yjQ1YIT8qu8Nvkplp8TuhuCHHgQNSQOJlbC2rReOGllj3ed
         qQZ7y3dZCAlQxauZNaNxFqq9W5hlhk/0ihsvLj+EmUcQlL3AvV9YJclOFYJ8NwlDJmqy
         Oxpll8vrXgQmyXPQaOj7gn1CMQS4iV6pEze2GXmoc9vrqLh1lP876M+fdDRBq2KZTEQl
         PD5PKCzCwW8ENRNCHRoh/U3Gc9Pa92bNv1N6IjWYbGTgy0SgKm+KSY3hlmku/EXMgy9w
         HO4iFf2VUNTmEt2cg8NZNgQyRPBuwTqDO47Y+DaCHFPuV8VU8qLWiuZX2aXaP8UwUwcB
         9K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590836; x=1793195636;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVdfobikX7vFrw+sXsu570+snU46eClKPnzChHPF63s=;
        b=iYbn4HIHv0Qn1kUqwMF0EkPCMPRYj8vQTeyfn9YN9tTJTI22Phq9sp+e41EQ5KlA0E
         Dc/5/AJr+9ilrgyrNZtNiIr0ACxs99qM8UGGsUhG1sCPJtEwDCTtNfUNwN9SZOGQu0bW
         Ziv7lS7nrQ3UqW5015lzBMMh/PjnS5J1CiZTn8VVDhhWRydw3J/bpdq+CEULKk1IAhmI
         iHg/xKAIDf/EEGqlmivCUSiBShw5KtbY7JHfrEV/9UpT2FQeSHQQV7sqNqc9HcnRq5Jd
         Sl44KSucfEIU+d/4tXXA/Xa2B5Lfjd9RMceb/hRvAaDuq0R5D5qAMjLq6iHDpy6/6iEo
         sYEQ==
X-Gm-Message-State: AFq9FYJ46TGztwR+YeuA3F+dpHKgALT3HdhENYCQPrvlkyvKjyokjNC5
	dOpNTQiw6svMHftg5LBIt/cps/Pfb1CwWu5uLbsvxEVdFffvsvorFdAI
X-Gm-Gg: AYBFou0YZ72nUMgr+hjNCF1Avjip4PXZvg/fxmWkA7mxcnZhx0qVT77qOoV1lqGNkX6
	/YlaKC6GyWK6zV0KKwbPmg/6oGx8JdYQpsASKkEKtr9lD/a4e8xH4TEngAZCJkIKoIX/ek6AZq6
	1j0s4Ttdbh6uz4kNh6SgTt9yJTG3UV9ejwZQ988xWd/+2hApAqQ+j+0bl6i1w7iXVlNX1ZEywzW
	NTCFnRHehghJnV2wtN1neQCnfKIClg5ey0sQ0hJQW7QS5SjjysnTj3U0jLZ8aM4N6xRnsc5K7sh
	PZ8mWmHPRzkdbN+ms+Ww89jhcsoM6iqxyRJ2Zzb0J3R+YwyQT3Gmg/mdiAzJX98oyRVU8qirTlg
	R2KoANboKf5KV8zH9BwQEFBSF5+/DR3/5oCLQfPY1joezoEwYvhGEXrSmCZP5fR5ZG322AkIu+3
	Bys1Rv3y1cEQeI4w7pcqzYEqDXRhRCsIogPgrlHcG8J4NOIXtukJA5sdh8yol+qbW/uKUwrY6Ue
	l1Ef3nMN8eE5WtIFV8LXWU511k3uQjjJjvZxeC32hBTP4VqRssJhGloqygkUOIqis1QAP1naOjY
	n0ZItlIQdpbhWm6S35D8hSLM0I9ZiBjnbzwAQFoCxxvOQuHqqFkyL1GzV/sQ6DOejla97knnJGO
	n6kgoLoAfwIqw7HLl0oL7/SXZP5u5udK1pvvq8SePzAlGgicqdPnw6rkfJZVvp9Y=
X-Received: by 2002:a05:690c:a0a9:20b0:8b0:ce9f:29a5 with SMTP id 00721157ae682-8b133cff2camr7680127b3.18.1792590835386;
        Wed, 21 Oct 2026 06:53:55 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13014b813sm11517467b3.38.2026.10.21.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:53:53 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:53:50 -0400
From: Jason Perlow <jperlow@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>,
 dwmw2@infradead.org
CC: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_intel-iommu=3A_DMAR_PTE_Read_fault?=
 =?US-ASCII?Q?_crash-loops_a_PCIe_wifi_device=2C_v7=2E?=
 =?US-ASCII?Q?3-rc7_-=3E_v7=2E3_final_regression=2C_repr?=
 =?US-ASCII?Q?oduces_on_one_unit_out_of_five_tested?=
User-Agent: Thunderbird for Android
In-Reply-To: <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com> <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com> <74570358-8085-4767-BF76-D865CA95853E@gmail.com> <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
Message-ID: <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Thanks for the pointer=2E
>
>The only DMA related commit that I could think of was indeed the DMA dire=
ction change=2E Hope restoring DMA_BIDIRECTIONAL fixes it=2E
>
>Regards,
>Arend


Restoring DMA_BIDIRECTIONAL for the RX pool fixes it=2E

v7=2E3 plus the change below, intel_iommu=3Don (05:00=2E0 in a DMA-FQ
domain), MacBookPro16,1 / BCM4364/4: 15 minutes of traffic, 7=2E25 GB
received, 899/899 pings, 0 DMAR faults, 0 firmware crashes=2E Without
it the faults start within seconds of attach=2E

-	msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
-						     DMA_FROM_DEVICE);
+	msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
+						     DMA_BIDIRECTIONAL);

TX stays DMA_TO_DEVICE; no faults on it=2E I can send this as a proper
patch with Fixes: f0ba5fd51ff2 and Cc stable, unless you'd rather
revert the whole commit=2E
