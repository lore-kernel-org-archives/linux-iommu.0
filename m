Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2A3FB06
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BByLWwxC"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680d4584a81so31970836d6.1
        for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704880517; x=1705485317; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PF8Pnin+c7FGrLLhPmlT2Lo4TVZlQuBZ3mnFy05QDco=;
        b=BByLWwxCpZesGzp0XFHSpZQhcIhSR9V5gQAKip6MZULslp4KqMaKIgeNx61muCgRGN
         rqH+j7lUqx3wGoGtpM/s0qdHSurD2XJ1E4S8xgP9jMZVwgWpGwoxtOwJCZWvxt5SQmxv
         QyCUAQ2qRT+SXh2aFRclIPY45eBhmHwYptdlLtY7YwHLgkrg8rHO93yG3G7LOfs1AvS4
         XzDYX2Ti+xLhUKmV0OOVYaieOJs/77wBR6+lO3XZVK+JDo7lmYKmjRkHArCydBmMXmBH
         s04f4o8mzjLnYML8W/DuW9vAfAqDIgYMnQ1jwpYhFlyiV2EtwwI3yTu8i41hipvbZXl6
         O43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704880517; x=1705485317;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF8Pnin+c7FGrLLhPmlT2Lo4TVZlQuBZ3mnFy05QDco=;
        b=CyRC3zclzVLtHzjqon4YNo62mP5z7eHUhLUB2QwI4JzuEKLg8bf8I63sdLrMpaG1AK
         yTIEwac5kYw7XJMU6BtKKawqtOrEHdrynGSKV1WRZ81yMDbjbPIhZcQCl+Qk4pXgoT0I
         R93gCJCtrLey5DZ169y8YjHeDZ0CfNl1CM2KearlUrTId7nOr2KAZmpbcKjksqqkxPXJ
         OxArcA4xWCuy2ZST/6pOK4pRQF0XGQruRNSTNG1r1M9MTszRaDb+IBfbukCXJNSV29S+
         u4Xgw73HmVQjddUu5n9YAc2Ok463pgrgsjlVhbjKWNZ2NPm45hd2jgSZGSnpuXyzNl14
         mzTQ==
X-Gm-Message-State: AOJu0YxIpbYXrupgG9vUyrP8V2GXgN5GshS5BTzrcieiMaX5rTiCO7Gm
	Eh9/YHwjzPwAXbLE53i2atolP35TlKNUD6sFX9okvyBzXYsX3Q==
X-Google-Smtp-Source: AGHT+IFWQ90PwHYJKm3SIj7TP+MnJvWEufs4ZCtlIGJu7qh+N8K36VlQcymcBZzR4x3jvFuIJfHmQGs1aTCwoQiaxow=
X-Received: by 2002:a05:6214:5284:b0:681:12f4:158f with SMTP id
 kj4-20020a056214528400b0068112f4158fmr2908460qvb.41.1704880517254; Wed, 10
 Jan 2024 01:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
Date: Wed, 10 Jan 2024 14:55:06 +0500
Message-ID: <CAJHePoZXinTe_8=4mshWhkV315qGcV9xNwSv=CEE_Cog99j2aw@mail.gmail.com>
Subject: IOMMU iotlb cache question
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am working with iommu on Linux. What is the maximum number of
entries iommu iotlb cache can hold?
