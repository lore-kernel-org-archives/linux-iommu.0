Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935F7C
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 18:19:50 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id y4so50449560edo.2
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679336388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yzAtbjstrZsUjwjpCw/bfjEIUoFPHmyawonL0u7Vnw=;
        b=ANETRw6VcPN8s7WEVSeoInImC6YG854DnxRHzElZcb2lgYa+1x/0GtrJSycpnMLEsq
         I1G05dTfuaFibZZ6PLiicxYrBEQ8+t6MdhDdgRmdpWgeK0XyalhSw7iXjR1mLE/w0oRy
         MZyQ55cf/hxlrg8z8KNX/IHMqbCjMxRSrwqHgOyyQm0WLYhGpi5pc1t/Up2HaQTVGX2+
         1E0jotyqpAoJCVWmhTaxZZNSkDJXwTBJLd95jnqalu3s6P6QwfLqBAFqDAr+ShX9K1p5
         Li/5qhxgiLa75Sz/bYhWt6/Mg7giiYdktzdUYBBs6SEGcu/IJX6/NeKgAjoQPUwKl7Ag
         x2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yzAtbjstrZsUjwjpCw/bfjEIUoFPHmyawonL0u7Vnw=;
        b=JNLkYImqCCjgKO/mHxgIpUDxYWdHBi+uA4Gps3ovH9Pk/LPzcepNky8IqHHLBLcG9m
         sZhnEAKIPDhHxTeNjO5tUK/abH4cPdqi7z5M8AjLFjSvl9dT6F3tVScJ8EALkVNMg0Sw
         yHebiDBiEEcspbRY2ka7+bjbf9tMO40crBiweMYqT1RYSR4+yNVRZ/nKgqdM1BEYKuZw
         Si9uu/x441dZk7rU/oLruNiLijXT8GyjxD26ju9PulOS1a5U7JSBBH4q7NeSHsqm/Fvv
         OajNdn2/ssZ/oQUyy731C6vpeahGEw/gTsqMvOXYREX/XXpWsYhjkopXFVME/Vqig5Yo
         rDUw==
X-Gm-Message-State: AO0yUKVVhCEWxDt4ZGg1C993eieh36+GkjyQLPokCAr+3jsdlV/YOquA
	PH7Lt3ELj89cVljknfnByduJLhvOd0Wo3Or9Dcg=
X-Google-Smtp-Source: AK7set9xAfo43i63Uq0DS6R9gBuA0Ce77YCStFPMj2hTG6DUCRrm5bRlcvH59L6TzpbWGMa4pcLOJQ==
X-Received: by 2002:a17:906:2b0a:b0:92f:efdc:610e with SMTP id a10-20020a1709062b0a00b0092fefdc610emr9657574ejg.66.1679336388438;
        Mon, 20 Mar 2023 11:19:48 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b0092b5384d6desm4722243ejb.153.2023.03.20.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:19:48 -0700 (PDT)
Date: Mon, 20 Mar 2023 18:19:50 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: eric.auger@redhat.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Message-ID: <20230320181950.GA168730@myrica>
References: <20230314164416.2219829-1-jean-philippe@linaro.org>
 <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>

On Mon, Mar 20, 2023 at 06:41:09PM +0100, Rafael J. Wysocki wrote:
> This should have been posted with a CC to linux-pci really (now added).
> 
> I would recommend resending afresh with linux-pci in the CC list, so
> that the people on it don't miss this.

Sure, I resent it with the PCI list
https://lore.kernel.org/linux-pci/20230320180528.281755-1-jean-philippe@linaro.org/

Thanks,
Jean
