Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3421DC432BE
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:00:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA94160F6D
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA94160F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6E0E831EF;
	Mon,  2 Aug 2021 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtDPEox1BsrU; Mon,  2 Aug 2021 13:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C073D83294;
	Mon,  2 Aug 2021 13:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D302C001B;
	Mon,  2 Aug 2021 13:00:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF3F4C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C7B940190
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jmZ2_Lt0oMy3 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:00:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFC5940004
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:00:05 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id ca5so25039440pjb.5
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EeSreHE5hdlnf0oXwm47d4tHu8/yxl93O4VWV6niMlg=;
 b=efFY4vl/l2ivNbm9EOrCQxUa+dPOqt+8w3noLnVCdDetf0McOpBx3fU1tspnDVVuA9
 7Pzv+sfvPIPgVGU0Gqn+pSKd3nKVxLIzug5jkaYAf1sxqB4Sj0UeiEE6tIsKyIsNrbdb
 ZzB+XhOGshwvZxs1k3uAu6PqViC47olBDYUYasFKmXsBP6Tc5r37JShifRbS9KCBLzOo
 ccydI/zYibadoznRJjQWxzc/7VlNTvJt95AEOP6ibHmciLPQPtUqMmcQXmeQ5eZpI1FU
 pyJaLee84JdYVXLzgQtCDJTZdDbbh45idglyEUAoA7BOt7lOK6B0ANXplELatDb4KrR+
 M5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EeSreHE5hdlnf0oXwm47d4tHu8/yxl93O4VWV6niMlg=;
 b=lruAtCOYYlDTPGL2uHz1ZZS/9VkeMZ5rrdaSDqO+np0vJnKuweiNSng8qan/3eLKnF
 P+sPNUYTZvbIGZ3bjrVJsm8wexSiBKspmKqkalrfZKtMUV+Y3clHA/hsDZJZ3hSft+pc
 HZRfcZHyIZN5KvVz8N/0BqS2l1a7ltIsuFCo12AQ1OGHBFQTqdOD+RzXj0JKwAxYD3g9
 lFEJmlSJ2l6Xq7IaYTB144fMG9MhbUfRchHxI9/nX3dd0OqNZeQOEx7PCMrQUWHLL7Za
 hTr+4h6dsbRRhYKul52AJfyXep+zZfrRc37pCkJZ/52/ZxaVo6Fd/1WVmspmQsUi13fL
 lOjA==
X-Gm-Message-State: AOAM532kL6Zn4I2fd42eYhniBCSvQxkkSnl3QG6n0fL/CVgqcsCTZYwy
 BBMhGdrUIcPc1wK1VAzuRGE=
X-Google-Smtp-Source: ABdhPJwQqurl+5kiEreCzf7V/W8FK4cyMJ1mZbyof3Kxoh8aAKG0BtZ6XERTRpAICjuoFK7OauJ+1Q==
X-Received: by 2002:a17:90b:3556:: with SMTP id
 lt22mr17715473pjb.174.1627909205346; 
 Mon, 02 Aug 2021 06:00:05 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 c16sm12058607pfb.196.2021.08.02.05.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 06:00:04 -0700 (PDT)
Subject: Re: [PATCH 03/13] x86/HV: Add new hvcall guest address host
 visibility support
To: Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-4-ltykernel@gmail.com>
 <c00e269c-da4c-c703-0182-0221c73a76cc@intel.com>
 <YQfepYTC4n6agq9z@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <996e46e1-6776-6c87-d791-0df6f0aa58dc@gmail.com>
Date: Mon, 2 Aug 2021 20:59:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfepYTC4n6agq9z@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 8/2/2021 8:01 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 08:29:41AM -0700, Dave Hansen wrote:
>> __set_memory_enc_dec() is turning into a real mess.  SEV, TDX and now
>> Hyper-V are messing around in here.
> 
> I was going to suggest a PV_OPS call where the fitting implementation
> for the guest environment can be plugged in at boot. There is TDX and an
> SEV(-SNP) case, a Hyper-V case, and likely more coming up from other
> cloud/hypervisor vendors. Hiding all these behind feature checks is not
> going to make things cleaner.
> 

Yes, that makes sense. I will do this in the next version.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
