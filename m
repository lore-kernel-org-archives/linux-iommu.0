Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D941859
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 13:48:22 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id l15so3033337qtv.4
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FuYaSuLHVjl+nMg8LeVo9P+/juH9VZJxeneSMIJjk4=;
        b=joYPAYFh1lubtvMUJKKM50dbz1msMM8q6QwvCh2ZF8qS0opgo0aDoilvZiLd0a3/R1
         q+XwGT6OX+KHe1xusmSCp6gTs4xYQA3iGGoEEIY0UkiN+ieE4GRYCTtv+FnBqfoRVi0c
         YQPw25Ztp3XlRzsRxg8KU3lDJT/M/Kf8M7HFWqIDYieODHwA+Cw/DaLW/57Gbl6ExqAQ
         mKiOS7Q2xeuXxSWN81DDbNwRdZDSRSlKmkLvgyHWy0cxMoof5QOdaWl6Kdafr2HWF0/F
         UqVopqAQja7CW2NtZ/RxZ9Ca5JIN3df61F4SDrPqoCNbPF0Bz1UVnepxZI7GDU4hXSK5
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FuYaSuLHVjl+nMg8LeVo9P+/juH9VZJxeneSMIJjk4=;
        b=SBlIR+k2MpKrUTySdrMpB86Mbqd2jvlVNc5M6g9zq7dZn/QgkKVDKlvKngxqsF0jRy
         2+A0KiZfIEyLVu/2KvNbYI4t+lSdPk3YijavJ/jo9rMssoPdCTIIXbL3yous0Oi0q44p
         Wuh6L5fMbzUUbT7fQG3yu6j6SkpX1iOZYXyMSNQ4mr1xKUpbG4EH7ZLjY26/FSRAvuLI
         67Zx+Z3avFctd+gy2pHzR4YIDUfmMUlVYu6F21qKmxDdzPGoSf/8IMflYSawammg3/S0
         ow54VLheAi+IFZlSD4FJBm5OkBXKiN6D/S/8n49fe7rMhijfktg2wfdslmWk+FJQwfZp
         2phA==
X-Gm-Message-State: ACrzQf0vysrCPBt2KCC583wX/q1p94PSr/a7b2ScSFPXqf29bAXj2cMC
	wzThMHXoNNkAXTXCxnqBohVejQ==
X-Google-Smtp-Source: AMsMyM5GOMP8UcKyjRRp9D39ozG1zvgW3zu/OM7VYx623n8kqqwZBN0eCD4+ZfaJNF2wQG+kvUtNFQ==
X-Received: by 2002:a05:622a:1304:b0:3a5:f04:5fe7 with SMTP id v4-20020a05622a130400b003a50f045fe7mr29245810qtk.158.1667569701917;
        Fri, 04 Nov 2022 06:48:21 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id e13-20020ac8598d000000b003a57004313fsm466229qte.3.2022.11.04.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:48:21 -0700 (PDT)
Message-ID: <52abac38-b395-dddd-0c2d-886307b8e2d9@linaro.org>
Date: Fri, 4 Nov 2022 09:48:20 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/6] media: platform: Use IS_ENABLED() to check
 EXYNOS_IOMMU in s5p_mfc
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
 <20221103195154.21495-7-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2022 15:51, Sam Protsenko wrote:
> Now that CONFIG_EXYNOS_IOMMU can be built as a module, it's not correct
> anymore to check whether it's enabled or not just with #ifdef. Use
> proper IS_ENABLED() macro to handle both built-in and module cases.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

