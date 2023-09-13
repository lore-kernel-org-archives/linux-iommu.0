Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B31FD6
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:16:36 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso8309060a12.1
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589395; x=1695194195; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yn21ujmkr4Sp+EA0gnf8dygODVc/XuXdjn0LI3sjZCE=;
        b=aAkgXbSV9ax7kwAKj59YLGZfHNEkS3VocVHsxNr+U/P48svqDAYzsx8px+dSJ6503T
         hDZBP6TA9eWEXRKgG5SWik4uTP0kHAnoHPyhmThFXZcIkhDzx350U8K9jQtoqjmnyD+n
         LOKftlhMorCTADfVLca3VEAWD2Mu7wutyPwxZdsGIDvx0+LQt6jWnWgmph3VTMhXQ6DY
         lAGgIsctL6CX3B2eVMRnQCxY1KARZzlfNaul7Gf3YQ0UGiSr9tvkvu/b/V8V/FNCDD0O
         XIFxpQxj8Z9LVdOnOrdu9E3lhD+nf+DriMPy4hKeCHUgl8NN2ltmtfb9Hp5SzntzSV5n
         y3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589395; x=1695194195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yn21ujmkr4Sp+EA0gnf8dygODVc/XuXdjn0LI3sjZCE=;
        b=nC9+jXJZI7XRj853FwLTlDNWXewi16F2laO6wXOI5ezN8GfyRikaudlngocGB6Kb8Y
         7rDuGEhiRlW61lwOvCTjQkfnkl8RbcdOa4c/xPtg5mMODfHyOcZ/bUcfY/55TBp1bWUr
         c4YBVBtU4eTjmMIGVAMOi/z2UE7/JHscNSIreHlmPgfOdnvtsA5e3FlF4YxokeUnBSRS
         PhdmmrTYHsOccM0qTcxg4RFGohjiKiUROz2ZIReGOmyM1a4ldCf62tPCNMSdhA4XwSoh
         g8vxxr+eNqQUz1cutRpw49KqhE9YZw6qdnfXMkFjWlDE1k4jbxmXPUjKHCl7p3YyMQSc
         4slA==
X-Gm-Message-State: AOJu0Yx5gP3YxH7bgFkycV2yGQiVVuJ6vuwe1krtXp1B7Sv74DTM0gG1
	SP8awmnrGxBRg5jZhc6TQcyomA==
X-Google-Smtp-Source: AGHT+IFyf9Fx/pf35KrNLfez0lmkNaBYKL0JSrB9CFz9ETZ9MnkjYUX40l83RXA8JXM9raiowLn7Ng==
X-Received: by 2002:a50:ec8a:0:b0:523:2274:91cb with SMTP id e10-20020a50ec8a000000b00523227491cbmr1504709edr.12.1694589394834;
        Wed, 13 Sep 2023 00:16:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id eg27-20020a056402289b00b0052f3e8c84fesm4786096edb.29.2023.09.13.00.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:16:34 -0700 (PDT)
Message-ID: <af5b83c7-94af-1779-68da-78976fc68fc7@linaro.org>
Date: Wed, 13 Sep 2023 09:16:32 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 08/14] dt-bindings: remoteproc: qcom,adsp: Remove
 AGGRE2 clock
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-8-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-8-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
> within the interconnect driver. Attaching it to SLPI was a total hack.
> Get rid of it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

