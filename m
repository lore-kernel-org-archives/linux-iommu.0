Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6722ACE4
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715663; cv=none; b=NpdGuuUSgTuxqDrKjQiVwSZyOmb4JE64VErg9CHRQFARgOCFeQePpGsrOLnNA4ZZjE2kHkq7QwaqyYVpTLYGmKfdcEXT9ojOFYMT1cC1jvBu54cdD6spHkwdw1pLGj41ncNZKzcyvKLj5dctD7iCqTaWbfIOaeqn40rPljctMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715663; c=relaxed/simple;
	bh=ftFlFL8Hf6gjCPdcRFrVx2YclVhyvU0X+h6fy2EfzIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cFO3PXzGsB6yixtV/5l0MAknzrfdpXUu4gXI6KNn9m3t3JXaOeDaBwkBabo9S53Yi5b5hTn0zg0PK2jgBiYr9aW3Dy4Ln7JPbMbua/zDGJWwKKNCPfgwfJ5cKid3cBo4D8hpMXMzCqCrGWNmHGcWXedVvFhsPzDkymmibR1m6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BTgkeds3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTgkeds3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1519577f8f.0
        for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715658; x=1735320458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=BTgkeds3djWKw3z4InwyjNr3kKhN3HaaGhDMZQQ4xvARLBtDrTRLyl8bCggb3YFp7G
         1C7rb7WkZu+S6G17YVBoij0VwzFygBc83TRt0II2JS5sD03nv9rDIq9GMbiIOhAhNHS8
         9yo1yTk634L9n20oCRXduM36JaFSPGwBs8ZwwVimzY4RAfr0zcssfPyl5YnfxqFscp4S
         WOihU1+Roha+8b+/Jbweiq4u1OhOWn49LhLEoKC/OuTdwxqwmwiNl4Zf+fIjbTqGe53M
         L55EHfGoEXz1MwzE9XLyF2KumzrHiK8Kp3ynhPy5I6xN61/Ur3ZHQuXt2I++QjfzahB7
         bsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715658; x=1735320458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=YiijkMtzDz/5mLbAuAHQEmmK67Cbl0e4yW/I0uiYfEMlhBMiqLDpOesz3486l7lR5u
         agMgUL2++ZLme95gnsbtaYYstAqACTEyyOJNtioHj70AAQpIyuat0JVya0RFhq/1GYMa
         axn6/SYAo3Jq0SKiqIiw5BFlNL08BMvJFwFMYsuShzSyvHV1UTZHu9VMJhEbj2v4WU4U
         rHQbUHGi14UyK8SOnWzZcumwcMjGAWVaCnVS7qmOLATdhtf4QNm2stQh04qK7F1h894x
         Jm79F37+RwsMFcXTzv1vGyZ4RuIuM6fFPJmArVFGDJG2nNSsM/3Zhmt2XHZqiWC+bAcj
         iU0A==
X-Forwarded-Encrypted: i=1; AJvYcCVv1UarskKf0n+ZNeHSMJxRcOSLclZVrsMj4Cjlo2FOvG/9wCuR9znaSItrhnn3r0GZo23cYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1W3m+zN8MzZBTg9qOFw+VXnMEEAF7o7WUCfWb9NhOvn1BnON7
	PwHMJEPbgUTkFIt2vRqUTlnpWBXC2UXO6WHhWux1RSWOHbi9jXPwJFNAnCYMCcU=
X-Gm-Gg: ASbGncvreM6CAtkQ6+07wedVBMjCTmoqqA/WqcbD0nxLwcBcQofZGZeF7k+ljAoMQr5
	2xsBsmpUtQk7jv5i/BQTckmhetS/iM75DSZroh8hVF3Pz3YuMG6/koUNHtYQ2EGdOnNfH/hdKM7
	x/ImLI8X562rQTX9DfuO4doitTYW9YTqZRU2Ge8CGt6MtOn3NyvVcQJVTWV3tLrb2NhW2nuQvLl
	DacyZo1ubZsDtWHoJrJxhazhDocLU3QLmjwOUGEB9p4R+KyNAr9DDSbMDpRwWns+x/a5GdDViU=
X-Google-Smtp-Source: AGHT+IHQofl14bIpVpiQqz6qAEwAjKsEmWVjRCOjis6wH9jKfvKMjWLHCbYlsDgmYPDOjR7ci+Y7xw==
X-Received: by 2002:a5d:47c3:0:b0:388:cacf:24b0 with SMTP id ffacd0b85a97d-38a1a1f7253mr6745803f8f.2.1734715658179;
        Fri, 20 Dec 2024 09:27:38 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e357sm4642915f8f.72.2024.12.20.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:27:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-usb@vger.kernel.org, linux-mm@kvack.org, 
 maple-tree@lists.infradead.org, alsa-devel@alsa-project.org, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-leds@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.net, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:27:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

