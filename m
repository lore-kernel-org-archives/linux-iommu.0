Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273B20E3
	for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 12:21:15 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4034402wmh.0
        for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 04:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmbM1Qy6O3VP8JNoHwNoRaV5SzbpRE5WRsZhiU2waYk=;
        b=nobdV8gwYafyOUn6CMSU+wcUOeAeHygRPpwdEARuYDAknr6usDVtaO8kUOV5d2kMa3
         pbB7VcXCUpTt6fd6FxRbu8zzTQGSH76klhjcBsUQCSQO8P/lPBgsnOmxUshj5KJjv4UY
         VltuS/4iLRVDsvWp+jLOwEw6sZgIYxZ8Wh86fKNVig30b9OjQF5gWLPwCEI+Wopbugu9
         p/j1Co4AuL7tcZVJuF3MbwHTAgyOggUVsLhq540VTQUiup57dUCaExwp7+ImzkEWebuc
         tciszF7f7uJqqXWz/n5orV9XtAeAFF2EyI+ztr182dE97h6kXE/jJ1AAgsg3cmzm5EB/
         RbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmbM1Qy6O3VP8JNoHwNoRaV5SzbpRE5WRsZhiU2waYk=;
        b=r5CdEmcWtDp1XMjwOy7kQTYSvbld1YOS2ZGDWoGjG9fdkYCTE6nb58hjmQRMO+6spK
         atdKVN+pTxlQJfi0M86dJEutvK9apSyQ/kYcJBrupKDkply+ueiiTRftx8WeksGTONLY
         akcYnEW1PumayMtmgau6QspACy/qEzZgig495h1rIvOdN0EQ5V4T60JrAW26HTxOmbDH
         G3thY/4iHIJzuXchkpEW5f/97H14j8zxv5TGwv9qt62X/IAiQtKRM5LA6gcSjScgaFZg
         5ZAeUUjewEHVoHvsEVNv6vdcko03uDWjrA914jc4NH+zpr3A9moMbEhLrTdXNS2sRYgP
         zVgQ==
X-Gm-Message-State: ANoB5pkveLDsjMkxch7ckcjRcx2G7+eLyhh19ZJcRj+z58oNwmJmhAGS
	nxRytk7XtEAiGaOxxK+Fbag=
X-Google-Smtp-Source: AA0mqf7kO/8QPwI2ecjT2wkkigajfkPpKiHrbj96BPqbcRqMO+sIDop9EbqtGYe+j19jk/BXqNAXNw==
X-Received: by 2002:a05:600c:3ac8:b0:3c6:e63e:89c5 with SMTP id d8-20020a05600c3ac800b003c6e63e89c5mr25474904wms.33.1671193274039;
        Fri, 16 Dec 2022 04:21:14 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm2476490wrb.72.2022.12.16.04.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:21:12 -0800 (PST)
Message-ID: <1614dc0c-dadf-a092-05d4-bdec1b2c2ae9@gmail.com>
Date: Fri, 16 Dec 2022 13:21:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: next/master bisection: baseline.login on mt8173-elm-hana
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Mark Brown <broonie@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 kernelci-results@groups.io, bot@kernelci.org
Cc: gtucker@collabora.com, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 mingyuan.ma@mediatek.com, libo.kang@mediatek.com, chengci.xu@mediatek.com,
 yf.wang@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>
References: <6391e1c4.170a0220.b562d.3c9c@mx.google.com>
 <Y5HrIhEfuEgGKuMB@sirena.org.uk>
 <ff000931-ce9e-f413-1540-ca2edf393362@gmail.com>
 <64296af0-e2b9-6f39-7dbc-6e0120f96fe2@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <64296af0-e2b9-6f39-7dbc-6e0120f96fe2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/12/2022 12:44, AngeloGioacchino Del Regno wrote:
> Il 16/12/22 12:42, Matthias Brugger ha scritto:
>> Yong, Angelo, can you have a look?
>>
>> If not I'd propose to drop the series for now until we understand what is 
>> going wrong.
>>
>> Regards,
>> Matthias
>>
> 
> It's fixed already, and picked upstream [1]... that was happening on more than
> just MT8173! :-)
> 
> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/iommu/mtk_iommu.c?h=next-20221216&id=462e768b55a2331324ff72e74706261134369826
> 

Ah saw that patch today and marked to look into it later. Perfect, one thing 
less to care about :)
