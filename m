Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1411F76C7
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486894; cv=none; b=i/1ZmXYf6tc918liGSnBT9FdxHFVpFtVrborLdgrDZDgNonxmmNzJzjort2AUeXkHFnxA4wBec14h9OcKpyBJMt30lknIQJ7T0K1y8DIKNj3jQ2JIYY59897TF27Xj2daTUl8jMDERYsFUOC9WpwuPC8v0OeAAZbiGk0AscHkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486894; c=relaxed/simple;
	bh=FNwkKYtNgY128tT+Ow8mqes42EjX7w9jGfWwlvxYpFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb3SW6wODvv8qyoC5nY+awSQuHOzxEDypGiQW9V3JDZs+OF+ZCx9XIGwPBtcfXsD4yv5JC9TLcZpQX6tKl+76B8GuAifjR0r74/UQ8+mYQ1dcmnwY0S4H9ubmkls+TEUgjkCNNZLbx5T4iOLJrv8YtI4BSVxXqJIsAKafEQwyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZQjuwYM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZQjuwYM"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c52000fso5861413e87.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737486890; x=1738091690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=aZQjuwYMHQ6Hb0RuRwb4WuH/mdGflxDHymmEozLSSogkVp5Lfil/H1OGjsP8Nv4vyQ
         1c8wHes2T9iZ35LQxHhDNxIANh6YITBHcA4N+bnI5cl6E2gVOXpAl7x7qeMui04mK0UC
         t848HfIKEX55WAl+IHojZ8sGCs2+E97rmGpZzq9Gz563Ud2loLbOiHXsciIap6xitvP9
         crP/oE2xBMc2GcMh9uzMrAOeU5+s2YnRic+wInEBSL22FjMRhSiD3VkVP4jWhL/BCKlR
         tmI/MRhpKgdHmpN7pRTtsES0GshcgXMUJf+2hiqtL75MraLX758skveiX+nYCNMZux/T
         c9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486890; x=1738091690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=m79phA/C0Gr7xeM0HPXV7nyMHWH8hhokeNBiVn+Q9eA5lwp5ykZN6GHt8WFH0/RKT+
         LgVTgA6vCEeyLFYVm70JrK/wRThEeyoVp+OisPuTo4dOhYb28jHYCz9X1OBS8aUilqgO
         fEEJ6jXQgzrpQCvo1UdNlVAXstFkcwgjwzjeTqOU5B3HjRYVtj2hrhpmeDu7xsqplZMO
         wdXfZrG8hgGENM1TPZWDVl/NaGmsEnmmWQpjNoE3MbNtzGa+pNndIb9z0+NjpVcCXy5c
         JAWDrpv+XoE+MajNts3Nwi5FbLMMQJZiVQZSRl/DzvV6crrr3iYTn/ILpV/SNMd3g7t6
         9XJw==
X-Forwarded-Encrypted: i=1; AJvYcCUXvTzhWx9k0iA/mjNwIVUSBtPRXHtkSLanx/wSb9jllZrzS+eg1Lm7xnAEIA0T9kexRHzWzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyglW5BhPOIYj91spwQI5OGe39IeMdHYcjSrQGuUpddDjUXrA22
	idEXtMLeEHrdyXsw/SWCPRNcTMzljnm4l+F/zjhRC2dotP167H2d4oppzg==
X-Gm-Gg: ASbGncsx+yZ2GZ44NoYk5VMJRjdmB7OVfP3t1TAsBDxafVnSlQtg8qxd0/XqK2VK18G
	F2sXCoemumQc1h+ckA1kN4tE9K88FqrjS0YAXlc40xQWxBFzmO8C5XUEClZB2O+fn5UBL+FIDus
	v3vCSmvRsrGJmQiZG61CvmKspuUdX61DPf7YF7DnYIpcSnMnS4v2CTbVQOzPAMhDpgu9iatQFJ/
	SHNoNFHSutobdRP1y0f8SSXrRb/Mqx39TP2TZRHXuaw8GiZQYFYyvbryMIV/R6qYs5GC6X6t8nA
	4kKFb90wZyz5QNpSShnrvqR6rz6U3w6T08vuY8UN
X-Google-Smtp-Source: AGHT+IHsYf4uWJtJquxpu6BCK5LzNsmbNdBxjyV8XtAX7uA9o8RcDRBM1QpQ6TA1g7RHIR/3tXuTUA==
X-Received: by 2002:ac2:5611:0:b0:53f:f074:801c with SMTP id 2adb3069b0e04-5439c2830e9mr6089244e87.41.1737486890327;
        Tue, 21 Jan 2025 11:14:50 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543bb6bf5b1sm56786e87.118.2025.01.21.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:14:49 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v10 3/3] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Tue, 21 Jan 2025 21:14:04 +0200
Message-ID: <20250121191432.1178734-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..4808c9880b3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6822,6 +6822,16 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
+DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Daniel Almeida <daniel.almeida@collabora.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0

