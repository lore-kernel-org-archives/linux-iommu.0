Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FB29A2
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 12:00:21 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id d14so4422131wrr.9
        for <iommu@lists.linux.dev>; Fri, 03 Feb 2023 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/egjzh03ngyXJ8FHTTg/0bQYtASQpdNMJv1hdvpB/Fc=;
        b=EZJDKhZi6FDDw/5bMJrAjrDxipE8DFd4zSfg7Is8OgI1Syp1Unmg9+kCVyntpI9Ah8
         ms1cK9oYqiMuEW8lJoL3+Pbky2PD7mVp7aCorL7I14++GZy3QAwRI33FG0ElzDNr0PWT
         vFaFCf+A0VIEt5SvaJNxmj6f+O0/MIz1hDNSX2iAm3KOxwx5TzVaYaspIpvrmIrRxkc7
         Yp+Ds1CPencAXduMvqvFaxN4/f87pC/z0lkpKQUXD9JWVr+yyj2quMcvN2sm1IFksFM9
         Gv02UHnSF9DL2lRRzKxSoQ/u3Enj0Y2GUc/NOe7C2vTDyZi/mLZQgKapmggqUNV9lM7K
         7JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/egjzh03ngyXJ8FHTTg/0bQYtASQpdNMJv1hdvpB/Fc=;
        b=lrHgNhWPjqzgYqNNRDma578UdW3jnVSLebMbaeVywqn5TGWIoug3GYYf7rpeadF1Qv
         prxpqZMo/rgOlN23uWBKBpkD+QR9iQJQptlRy6QaDEdVayHcdR01Uz02QFo/zLM6G+1W
         4d0euDwiG1FzexJ09IkOuZ8f215JTcYtYEPUYOzvVaB6Lz/+QQu6tXCg1Ubr4kk8ul0g
         Ja3y8ToK22td5Nn+hA3xWTos9Nj66328e6oGheNiM58OX72wNSBLfyd3eFXK1yb7meWd
         hDmMOXXfGGCFXvzihKCDTmo9LcMcX9lgUWDClwMrIeYju5mZbSHZZb9MvOzJuedyBwBW
         iWDg==
X-Gm-Message-State: AO0yUKU7p/CgViVS+Z4Y4DuxrJsbzJ071PeEjYA3voWjk9oBqB0BBtga
	Tnw9C0buOP1aALn6NsrXZca0wA==
X-Google-Smtp-Source: AK7set8T8aMKg8ONn/ET9eKan7YGhEXPRxUtteeiVs5nS/u1CsnX5oz+t6Ydy0xu8bDo1Ib8w1xRcQ==
X-Received: by 2002:adf:e5c9:0:b0:2bf:ede3:988a with SMTP id a9-20020adfe5c9000000b002bfede3988amr10663907wrn.22.1675425619996;
        Fri, 03 Feb 2023 04:00:19 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d4612000000b002be15ee1377sm1486750wrq.22.2023.02.03.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:00:19 -0800 (PST)
Date: Fri, 3 Feb 2023 12:00:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, darren@os.amperecomputing.com,
	scott@os.amperecomputing.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Message-ID: <Y9z3UG+wEBn4i3G2@myrica>
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>

On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
> The current smmu-v3 driver does not enable PCI ATS for physical functions
> of ATS capable End Points when booted in smmu bypass mode
> (iommu.passthrough=1). This will not allow virtual functions to enable
> ATS(even though EP supports it) while they are attached to a VM using
> VFIO driver.
> 
> This patch adds changes to enable ATS support for physical functions
> in passthrough/bypass mode as well.
[...]
> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	master->domain = smmu_domain;
>  
> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> -		master->ats_enabled = arm_smmu_ats_supported(master);
> +	master->ats_enabled = arm_smmu_ats_supported(master);

I should have added a comment for this. Only found the reason in an old
cover letter [1]:

"When no translation stages are enabled (0b100), ATS Translation Requests
(and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
F_TRANSL_FORBIDDEN."

(See 3.9.1.1 "Responses to ATS Translation Requests and Translated
transactions" and 5.2 "Stream Table Entry")

So I don't think we can enable ATS for bypass domains :/ The PF needs to
be in translated mode in that case.

I can send a patch adding the comment next cycle.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20190409165245.26500-1-jean-philippe.brucker@arm.com/

