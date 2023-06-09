Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51B256D
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 14:52:48 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so20872871fa.3
        for <iommu@lists.linux.dev>; Fri, 09 Jun 2023 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322367; x=1688914367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytR9MFcgJFjU0KeCb0QynViZURhhNB2rI5a4kf4EOfE=;
        b=If656WD9AuMcDX43YT9UOK3YuG8PxW7XUjN/uvyXFyX/HIky9sEapTbFF4V5i70pYQ
         jXVNFnW5KirPO6h5F4wDml/Xu1YIG2yUP+vXNiY0Mrhfi4VbPSdPK1ZHQlyZrkpJXFsb
         xG6kextoAxDcFQRSrfXYLtbdrTLiaGotnz/8qj0e/Dn9G5pwHLT9AMqroKZzG5XEzCci
         x4u34AnstyxYHnx/umvWRsbaKXQWBYT0uE4wGUYRvtUK5T2danVjYl550rpuE2ZVTjnL
         KcDXYLyi+/lWZhQCpSyqmTgkTiDDPUAZ5qQ8tuBA3a0RIsp/16BBInUOcDuy8ZcfXaWC
         Ks2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322367; x=1688914367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytR9MFcgJFjU0KeCb0QynViZURhhNB2rI5a4kf4EOfE=;
        b=D5bJEkI+MIGy1o3g+zP6Pl/jtJ6HXLWP9r8B254hhVX5cG65ePcz9SWUPLzsj4am27
         XcoH8PlBF3aioCzsiT4HZyvuKj4T5kMTYcRjetDn7mhLQ78oAvYtzytsCpBMo2kYbXg2
         5ZFz82DfqmzqZI1aFmFEut0Y2tDQ+4xf9gqHnwalViV67d5NfdSyhN9MkRWaZNqSF4wn
         0wPQ912GjTtA3tcwubj5o4RaktimG38E/0GiefbEJFyiaT5K7kCQPLVG9WfBeOPD578x
         Dz9i4tNf3hT/54d3t/RWvxtw05CpJrS1spebSAvEo1qOxBZFJ7o7crs+jJgH2Y8IYbbf
         0WOg==
X-Gm-Message-State: AC+VfDxc619yUKxK6N79ILroNWl9FQsxki6lzHcn9WnPA7g9rVfgDK6M
	Sczjn0jahfJKUY3/CqbO1Ib8hw==
X-Google-Smtp-Source: ACHHUZ6p8J+gs0jIQ4AOzs+OWU43jonUXrSgri5LlgXTp2LKnK6h1xF8IXFP3nkwV/aH1pek+nY+Og==
X-Received: by 2002:a2e:8217:0:b0:2b1:bc73:6fa with SMTP id w23-20020a2e8217000000b002b1bc7306famr1306330ljg.21.1686322366828;
        Fri, 09 Jun 2023 07:52:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id p26-20020a2ea41a000000b002adbedc9962sm420713ljn.46.2023.06.09.07.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:52:46 -0700 (PDT)
Message-ID: <c3c12574-fc38-84ae-2a94-3c80fb9fb363@linaro.org>
Date: Fri, 9 Jun 2023 16:52:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sa8775p: Add interconnect to SMMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Parikshit Pareek <quic_ppareek@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org,
 "linux-kernel @ vger . kernel . org Prasanna Kumar"
 <quic_kprasan@quicinc.com>, Shazad Hussain <quic_shazhuss@quicinc.com>
References: <20230609054141.18938-1-quic_ppareek@quicinc.com>
 <79206b05-674b-1f6c-6eb1-ed45e6bd5637@linaro.org>
 <20230609125631.GA29252@hu-ppareek-blr.qualcomm.com>
 <2881f374-70e2-0057-f43e-7be12d32ae22@arm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2881f374-70e2-0057-f43e-7be12d32ae22@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.06.2023 16:45, Robin Murphy wrote:
> On 2023-06-09 13:56, Parikshit Pareek wrote:
>> On Fri, Jun 09, 2023 at 10:52:26AM +0200, Konrad Dybcio wrote:
>>>
>>>
>>> On 9.06.2023 07:41, Parikshit Pareek wrote:
>>>> Some qcom SoCs have SMMUs, which need the interconnect bandwidth to be
>>>> This series introduce the due support for associated interconnect, and
>>>> setting of the due interconnect-bandwidth. Setting due interconnect
>>>> bandwidth is needed to avoid the issues like [1], caused by not having
>>>> due clock votes(indirectly dependent upon interconnect bandwidth).
>>>
>>> [1] ???
>>
>> My bad. Intended to mention following:
>> https://lore.kernel.org/linux-arm-msm/20230418165224.vmok75fwcjqdxspe@echanude/
> 
> This sounds super-dodgy - do you really have to rely on configuration of the interconnect path from the SMMU's pagetable walker to RAM to keep a completely different interconnect path clocked for the CPU to access SMMU registers? You can't just request the programming interface clock directly like on other SoCs?
On Qualcomm platforms, particularly so with the more recent ones, some
clocks are managed by various remote cores. Half of what the interconnect
infra does on these SoCs is telling one such core to change the internally
managed clock's rate based on the requested bw.

Konrad
> 
> Thanks,
> Robin.
