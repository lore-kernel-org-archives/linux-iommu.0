Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DD1859
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 13:46:45 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id z30so3019425qkz.13
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+14ZUWUEMyjcOtsdl5nm/jkKpjvcaDV8XzIujT67FME=;
        b=emY++djerGm0lszovpr9Vd21PpMd2jQrNZj5Bm5+El/7axZfaUPx03EX+joPBi3JOR
         foCSvuo2+ptDMX9jhhVzuudgBAmDweLlg0vEuBWdMmVWmMokkd2JN5gRIGxVQq7ggK8C
         jnV+/Oi7Tbw9v3aKFhHHrKIy87EUItUyHn+kk9JQldlzCggyf+LOyyLcVMgFPq0spEni
         zcFlzW9Uf45dlopko0F8ORhfvlN4NvZr2VQzxfYNFcNjsUwcbhEUJDj7iOYtQroJxAXf
         Rcj2tCwKxRoXPbotImvGB3JqSmPk6J5GZBSb7mFDcC4jTOK9cG4ICKytnRRZiJqY9k/S
         UlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+14ZUWUEMyjcOtsdl5nm/jkKpjvcaDV8XzIujT67FME=;
        b=lRl+V0OPP3giiXZPe2Xs0o4dnKF7NdZx8teE7kH9mDviaiNwX7mibIznR7i5IXmPYF
         02v8WC8E4NDYZMq4MBP20eZu0jlnDDRktPB9y1QfslNHuXamEox71DAq+h7caeK8+g5o
         MA6mKCm0O7HuaWyZmUxamrzZ/9SUrpEnNJ3k+eqA+VVKev9w7DNcqWgTmuQTamxKvqc6
         K7tbDEwx3ivYh07jbSYQ6EGHbvGQc9foHxV1QqFruBY/tdwviLX3YKgqcTfEU4Cske4J
         D5dvh5ZglsExmaJK1en7FOZwLubzBjjJnC7zYhDFXrF3ULzab9CEXKdZvKZlqI1Py/KO
         8utw==
X-Gm-Message-State: ACrzQf0oO6Jzcaw7jYOLSyFTHUf+G9eekVOJDl3OP1yV3DSY0EeFI1j9
	auI1mE5tIOW9qRSXDad8kcZgsA==
X-Google-Smtp-Source: AMsMyM6DU+/lwsr/Q2kZzSsB9Lk0Dfgkv/qiMhXHBpS9JySuwMnyIwbnfcNc1Qkh1nbNtPUJFCjqtw==
X-Received: by 2002:a05:620a:1337:b0:6fa:2ab0:503e with SMTP id p23-20020a05620a133700b006fa2ab0503emr20386421qkj.348.1667569604039;
        Fri, 04 Nov 2022 06:46:44 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0039953dcc480sm2463057qtq.88.2022.11.04.06.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:46:43 -0700 (PDT)
Message-ID: <15eb2870-90b2-05dd-5a24-eef9dab6b31f@linaro.org>
Date: Fri, 4 Nov 2022 09:46:42 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/6] iommu/exynos: Fix retval on getting clocks in
 probe
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
 <20221103195154.21495-3-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2022 15:51, Sam Protsenko wrote:
> checkpatch reports next warning for clock getting code in probe
> function:
> 
>     WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> 
> Replace it with -ENOINT to make checkpatch happy.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

