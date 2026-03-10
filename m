Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5563B0AED
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148932; cv=none; b=tcNBXWb6RkDy/WITxYe44S3GXfThIm/JY2nv5a5NNFXNUnwhTthbz44nVaLQN9BmEdpnJNQ0pc6gJSRCpQ0F+nbAUL/K56xIvvdcCz+rSGTEfv1NxX8WnoEaECdyuBInnxdAf26z/C3xbq24WhejtP7gPoWjNMS+71do+lFj43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148932; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SK0o1wICFHUcqgkJj0MXzfOKnqTi9oJalIXCdqEcBLe7v13HGyTP+NYcKaWzbhSt1U/UJNFPBlkmaxQVNKWvBmJL5M2yOhHAK9OC9ly+5+xTdgU8Qx7MTQoLfcoqegOyP2CaW2b+1zgRrXvjJ81Bcg/yySYapxb9IfQqD/epCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zo0CYay3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zo0CYay3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=Zo0CYay3fNS6nNUgO9JjxVGq9cPty8oV+Lr9ojdybQ8yTkOX4mN9U3Jy00cnf/ksl5lySC
	yySxefhsO579pYAHU3v/+4/Km7BtCaevJSSgvrsHg4X0Gz9yvYwnOWWC6jIDZFWyj++WtH
	+b+fK8uNDufV9iRkUqAPcaEBErJYWuI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-M-lKjC2kNHOms3PqF8FTdQ-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: M-lKjC2kNHOms3PqF8FTdQ-1
X-Mimecast-MFC-AGG-ID: M-lKjC2kNHOms3PqF8FTdQ_1773148925
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7ea0bb20so1450837885a.3
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=O958J2Nm1XfCu2JsK/J55PBq3tZZoBNGg9RBfbheHUg7h/XNP1UuJfdHPhWvFno5kX
         JRzj6/nmM5F+uRSatAjtWXhz2lGAGOk16EAozI/adDHAdG0PkfoR8j6w1IxwH6v1gL4f
         m0XVia9JKPrpk8RalnpPPJMtTD5fvmfKbqqDL8Cppi4P/qovqCPjykIWChPEdgRmr7mW
         4X1BaH7prqo5qBdCBkiqj3Ln+i7KZhTIec7nLtrFp35Iz8FMCjEOsM/z5Mfw/tVzfTnY
         //cnozalh4FLlEpjzhuQADeBFNhxjIxU6ys3biO0JPMATUwKHB0HoQO7PERN6l5+khzr
         k5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUedf9tcju9O7dgE5IzSOb+fLUk26GhJdEx3kohmN0RKKIZ9aXyVG2af7k07rN6Kj4ad8JfVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeEDPZOlJ5rPttGaRoqWek5diJ5vjC0AyGmfLxHrq0y8r3p9qR
	ImEjMQl36QjIngOQKAnKB76yX0WxLuCFWQfL9sNB0Ts6yQJWjN8vmzJA0JVWqeuwdaLwMQvX1CK
	1sx1+5mhXA3FADSEJX99MooWxxbA1Lvis9JTebuicepCh7MW5ohTLnnW5
X-Gm-Gg: ATEYQzyQbU5PiF0RQl5AessNYEt76AYmQdk9TwDT4sQxLA/QY2/cucnJ/LWopWkVKb4
	FWVrYogwn8vuQe+ItAxIvFsTHmJVtL9tK8MlTJQFXRkuOhM+25gaCCP1KfWQekgt7C9/35vRZKw
	ZC4uCbswOrw/eD1YuTK4tx7tIfto7yyiIovW82+DnWRPgAup7ZWG4SuhKWRrj851R1c1/2vd4mk
	ROAcsZVQT4TGDEukpDclqXjs4IlQhIbYZAl61fu7l77vNuSBPJ9veADf4snw1W/SV+4TgiABqz+
	AqI6Ajcw1R6ROZN1EiSo6bv3Lx0vamexHg7vurLqAtqb3Q0KXsvHirkmhCPv31BMms7cIZHjfQ+
	5G3+CGfJLHJZdJhpHqqQk7hRwAFOySq0KPPF4MzU8Rdoc2n7ktVEjK82h
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830784785a.45.1773148924679;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bpdjtdvPRx9LWf8e0Vj7QgP8POzdVki-Oi9FnnION4s_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

