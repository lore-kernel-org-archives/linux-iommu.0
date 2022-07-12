Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161024414
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 16:21:11 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id a39so10456864ljq.11
        for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+eczaOZHX4TeLEoVuGZvZlc3YvFcSUgKh0OSE0sknQ=;
        b=lhhk7gHDxF++IOnhQqIAX8/FBtvR6oMIoA0r5phxQR/M5KWtbVwj2k4EydEVtu/pIo
         4w9XiIHP2kJ7Y1eHZzAg0f2k89RXidZkf9B65KcvuI/kIPD9t7L+DnaCt8J3qlvWxGmn
         2qGYQNUUFSJUuXXCuU1xPAFs3gz+4JQgHwdPAA06qjYa75mq4n0ZurQNoxUfbPQoPR2h
         Vvl4uRdviZwYFMFsnwRtgRNP7CjW+XWWwnlhW8BWddEcI+LIkrs8ZlrE5ruTZps3US15
         u67OhpdDCmO7BrpVt7+ZICSqDCN3OcoqT8ApozWGNmd4iY12CJMhYRI1SMbUi2bahh/m
         qfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+eczaOZHX4TeLEoVuGZvZlc3YvFcSUgKh0OSE0sknQ=;
        b=bypwjDZYMKUnIU+uF4gpXbuf8W4tnkLvBv/WHxbjn+87t+uIMuwe3nZZk1nq/0gMGW
         bfZ0uZ40AynaxyURdyVYdc50mpln8F2zlV0Ss+K3wKNWZ1cYj/cTqh+rVeh32jmhkWlB
         Uqt5dqlw6ZuJ+U6S2m1db4wY0wi2lCt8cSo17o1ZDrH96vfUWwo1shwnz0knjAz3xbdl
         A2ajvUMOxQporcUxX3fpvbsHTxB65tUcsO+EDNNyIgXhTnKjcZOx2iYAo9bz1FRTT3mT
         In/c3Fovy2L5xwEYOxUq4mX/W2Fuza+FhmW9idYVpp1hRQ4jW+TQmsRWMRjX6FYh2eOq
         EReg==
X-Gm-Message-State: AJIora/eq9FqMhgYQOfUx6jbb4RiuydYLE1LBdjvvhibY3e79Ng+j9o0
	OmuITLeiOxeoJmeP//CMMyex7w==
X-Google-Smtp-Source: AGRyM1uy5fRThCPAxo7NecWcdrhI0zdxdkzkxnBuoPdolEFSHJ0KXlb0BgjGw3e9yXOCH9xpzIrJ2A==
X-Received: by 2002:a05:651c:1a0e:b0:25b:baac:f415 with SMTP id by14-20020a05651c1a0e00b0025bbaacf415mr13791659ljb.480.1657642870175;
        Tue, 12 Jul 2022 09:21:10 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s19-20020a056512215300b004855224ead0sm2262352lfr.158.2022.07.12.09.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:21:09 -0700 (PDT)
Message-ID: <8fccb0fd-a7ea-dc2c-5604-eef3c93f0397@linaro.org>
Date: Tue, 12 Jul 2022 18:21:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/7] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 David Virag <virag.david003@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-4-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2022 01:05, Sam Protsenko wrote:
> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
> of failed dma_capable() check.
> 
> The original code for this fix was suggested by Marek.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Co-developed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
