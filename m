Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE8357CE9
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607969; cv=none; b=Xfih2LUkoX/9RbogVgHCBix3LVjH7nquYLN+CYNBqVmFsnf2xjDsxO4TltcMOJLLOhRjbreTPMwvDIqtBQw5hRtc6n2TcAUmBw8BKhmAgb2nvRc6RyGfWC0BKdsSRpAqbw4negX6at9D5HHtAeofzOuC+615ciaT2+LLHO6OFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607969; c=relaxed/simple;
	bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KySqzkmJdLsmbIsjLSVafJqpg8g94JNGTI1FPY/gAHcuR6ePc5jYxQBWHF5QDyl2G2ilWtNM8O0y32OqerO8qK8EjL5pw4m5JRKowe19MihEAcArX+PDra6uKQq3UwpkJ4Sc6rk500p9KI1upYZmVyskaqM0QY9bcKG/8SpzzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjbeR2O8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjbeR2O8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso48405ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787607968; x=1788212768; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
        b=UjbeR2O8MtufW7uTMjtlMg0NlDS39MshXZTJl5XzZJTJk7biJBiJl/XXEyMswm0Qsr
         ghHZzO91Vzy+ghwZ6ksuvOxHsR1/gXw7SUXUhzzl1/fQYAOPbhX9A8iVUKrzX/GJhpk2
         WM3Mpf/RToxWrXgFfvxJWTMW0O/Czw2xUSEUepDRGxon2G0/vQBKT9uJmDZUra3rcsU7
         A5izSa70uRXpWcZQKlzchfLhzX4ZazCRhzDCT72fik+ukRS1px8RGX1+kQ3NiEJh0zcy
         CRRqnJfqKT1DOnQ1jbw6a1suAcFKbkGE5/fOv42dA7RZ+SLGLXhz2Jx0Wq9g11FivhOd
         WETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787607968; x=1788212768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
        b=YSvt75iUGRs8hV0ufthKxy1HR2P7x4IXZWecz2SuadNS2Csk8owKhXES/KiDBWcEsz
         aJbpJ8x/oPDKcp092OcQGwTThZtIT88gvKBdKrLXltuqlH/EC9Kog5Ga9kschzE5Mqx7
         4IT0x4dCkOCk/spQtmHeyAvSnRzbXYylGBHGKYzNLc1G+o81cbaznTbQWyoJP12DAy2n
         Srk2xVHnM1iSdlFviTcERbILa63L8NuBVXLeyxQkwHlnahYd/ioV9Te4vfLbuDz2Rg+/
         LqdJITZgS6xpWpZn21f76zBuVb8yeJuuzn116uReS32tZsOK/WsUKJ5lwjcpcIcwJkA/
         nVEg==
X-Gm-Message-State: AFuF++mCgi442ssc/khx1OEwJza/8zfTQVh66WlFeQBUy4rp1skf1Ehr
	XYKkfX6b+bQoLf/E7q+DOl/TzA3eJKm6qNAN/TFnkG+iHHKlaxXs3e/R4oeeCXNjwA==
X-Gm-Gg: AR+sD13f/hpnzLxLOo2oH/zpkngZlljyQEehq9DM+2M2NYMbvWdGOFXTFfzEDt2tEJY
	B9uqWzAzDb1nlbuO2+aubbQyTNHqS6vzy+D4tdk071FPwJ8qR7p96gX+wZwLtUxf4uMo71RndK5
	ButXmyTyj4a5A6ZAwWfi6IENJRob4xzsfjFBjU3fwQOI/BpVRHqVeReQNFoybsSx1uTYaUkBsRN
	LAzXCX7qxkF2iFlfSOglepj+Q0CK8YkyxcpYlzC+FN/WJTI4QIlbGm3kK8H/RX1FAL99M2lOsd6
	Ttav1HNRNybeDPh2Snn2UTBQgX0E/3KhDgX+Q1+XMSbckOaT8w9Ae8PF539A4TRGKWp1/uikJzN
	I+ssYgMlfxfsSwoeGOwlVCSweiH1C/fj8FOqWMy+Ln35/+tj9E9JkMFBlTdqVTYQrPQ8aS150H/
	+7WUwSB/HM94XpOptTtt6y78NRESyKSTU8Nrtf4O66/2fDhqurklXf40bU5eUpR3mhuHHkYHkVD
	Ihiqep45hYeJ78uQ1ZlmD8C+3EPH3KluCFwqoHXEsY/UQL2Ib9v503fu/8=
X-Received: by 2002:a17:902:f142:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d6e07f52b9mr1305025ad.1.1787607967370;
        Mon, 24 Aug 2026 14:46:07 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef07a12sm2506753b3a.16.2026.08.24.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:46:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:46:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 4/5] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <aoy7kcQWw2XOfmJl@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260824122347.1588592-5-praan@google.com>

On Mon, Aug 24, 2026 at 12:23:46PM +0000, Pranjal Shrivastava wrote:
>Update the driver to call pci_prepare_ats() after checking if
>pci_ats_supported() and fail the probe_device if pci_prepare_ats()
>returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
>a failure in pci_enable_ats().
>
>Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/amd/iommu.c | 40 +++++++++++++++++++++++++++++----------
> 1 file changed, 30 insertions(+), 10 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
