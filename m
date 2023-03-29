Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECE2582
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680102189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlofjauJPlXfYADPzQPDVEUnQC/PDQRHvDqts/6T6UQ=;
	b=Yw3KTdy4slKjmcOrhSWeQ1rwm/9/ZJfoHzE3Erxewu/C418jipQML3HONQd2/5t9ray8JP
	T8IEs4Nvm0i9VRC94yR0taK2gT6p1NOfTbCrzyKy2hV1iB8uLUMs1eCV/hOlTHjIYoi7pO
	+Jhqn6rjJTThlnpUkD7QPpa2Fw7c1UI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-nSKcVeGxND6qT3X8piRpPQ-1; Wed, 29 Mar 2023 11:03:08 -0400
X-MC-Unique: nSKcVeGxND6qT3X8piRpPQ-1
Received: by mail-qt1-f198.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so4444482qtk.6
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlofjauJPlXfYADPzQPDVEUnQC/PDQRHvDqts/6T6UQ=;
        b=yaGngxeGI9Ykwf7br0NMYDSFQqNE7VDvS1OkpYJSp+4vBvAUVuYBBU6TVklX/W1kq7
         VKgVTyXKOn94TM8qm38Svt3qJvqsfQAHpiw0eJM2NUBkU4qP+Txv/6UXZEdsD0NWPO+U
         Ic6y+KOOT9VtE1q0dNwK0IPAZXld2wLPQ2MG6sGGxtCKCr+jhr70RB3AH0USa2uezoBx
         VrrEqdQ+Mbzp1UvVkfDyklIdGhirmJ3k2b9+01uPHh9YdhyPT0tsQmzq0RceTkKf1N5M
         j0auwL9Kd+e1B0Py3Bx/9rxgkKUhrYLY++0GCW+oQkhlI7UXWmnrSYMeSLJuQN2l4SlA
         qIAA==
X-Gm-Message-State: AAQBX9ezpm1gJYsMgsKyUWlxge70mq+G4MsdDGSU1Lu6drJfAdiYJMmz
	A8GTotMdKs+FDr0tL0hs6u91ai88/Q+y+qGKdb0NFi47Hg+CV3veTH6/aJ2q5z9tIKxcuJnixgy
	re1EIu40KWqrKVA8=
X-Received: by 2002:a05:6214:27c1:b0:56e:9ab5:cd9f with SMTP id ge1-20020a05621427c100b0056e9ab5cd9fmr31560869qvb.39.1680102187401;
        Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXCxRiiS8rCjA4Y3Ad7TR+rQzvZr5LeNmaq6ea2t6JngTuQWRCDL7OnMKrZ3QLfPO9P1kkbQ==
X-Received: by 2002:a05:6214:27c1:b0:56e:9ab5:cd9f with SMTP id ge1-20020a05621427c100b0056e9ab5cd9fmr31560837qvb.39.1680102187167;
        Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q43-20020a05620a2a6b00b0074860fcfc00sm3225464qkp.136.2023.03.29.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:03:06 -0700 (PDT)
Date: Wed, 29 Mar 2023 08:03:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Desnes Nunes <desnesn@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, noreply@ellerman.id.au
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230329071405.1568021-1-geert+renesas@glider.be>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> On 32-bit without LPAE:
> 
>     kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
>     kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
>     kernel/dma/debug.c: In function ‘dump_show’:
>     kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> 
> Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  kernel/dma/debug.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 676142072d997b6a..f190651bcaddc9e9 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
>  			if (!dev || dev == entry->dev) {
>  				cln = to_cacheline_number(entry);
>  				dev_info(entry->dev,
> -					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> +					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
>  					 type2name[entry->type], idx,
>  					 phys_addr(entry), entry->pfn,
>  					 entry->dev_addr, entry->size,
> -					 cln, dir2name[entry->direction],
> +					 &cln, dir2name[entry->direction],

Won't this just print out the address of cln declared at the beginning of debug_dma_dump_mappings() each time, instead of the value
returned from to_cacheline_entry() ?

>  					 maperr2str[entry->map_err_type]);
>  			}
>  		}
> @@ -565,13 +565,13 @@ static int dump_show(struct seq_file *seq, void *v)
>  		list_for_each_entry(entry, &bucket->list, list) {
>  			cln = to_cacheline_number(entry);
>  			seq_printf(seq,
> -				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> +				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
>  				   dev_driver_string(entry->dev),
>  				   dev_name(entry->dev),
>  				   type2name[entry->type], idx,
>  				   phys_addr(entry), entry->pfn,
>  				   entry->dev_addr, entry->size,
> -				   cln, dir2name[entry->direction],
> +				   &cln, dir2name[entry->direction],

same for dump_show()

>  				   maperr2str[entry->map_err_type]);
>  		}
>  		spin_unlock_irqrestore(&bucket->lock, flags);
> -- 
> 2.34.1
> 

