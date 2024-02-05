Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A247F59
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157042; cv=none; b=SbQR4j2LD30VH5XS+Big+Oz47/ZI2KWXsJdY+j7aki0yNYWbJF5sr0KEQL5CpDENm1oAOFjbnYYZl/UrAec037yv50QjmU0UsNY3b8ynHvUj9yUS5rCf6oOG3c28GvTXfEI65GlIlBdo2ODEUqAFOs5mupjidDw8ytGw76PZr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157042; c=relaxed/simple;
	bh=LhCS1ICE+lBvaO8YlYfviwFJHIwlCBRFxZftdvpWuMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ahNjRkvnGSnwuLexXRZrVNlVE+Sri5c6aKIL/ES2Je8XIF0RTvE767vKGUSN3lKmlHO0i/9BSOioMU4qeQ5Kgj9YdxbhDLgLTwqDjRb0v9KsO6njwhi7AO9mXv/kkKZMBhSXYuKDsoT5fYe+iNcjVkVOMlJIATSenb1HqIrczBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmGITMfZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmGITMfZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d93b982761so33425ad.0
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707157040; x=1707761840; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX9WAPSzH4fqkr2cx56EeyUyPmftS4JQYp9iTqHs4jU=;
        b=KmGITMfZJMh773+Iy+faft0plRT3ne+USnWfyFYD8yYchie19pLmLWiELvb1yZqanS
         DwwbYezBj+aJMowh6YeIAM21mtasu7hYOm7qHOoM9tEsxefNZkFZcaKQAb1sqfXmE7++
         DsD7LrocrKSm6NSzSsberw0/5SpNbSW2Iqvf99dYImYq4KdjImGvVYaOcwZIPWydvetC
         f7FOCbcEpaTqXlYkioA2lNfpdFECf36ncEinbwmW9fwrSPG40zVkB1Bp3fq7qzhGJE8d
         tOn8PDeOv3v7Gd2IlrNfUFTcJJcQ9aO1OHch+akNP4a9E82XN29Q8ELEQSOTbxQU1Moo
         C9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157040; x=1707761840;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cX9WAPSzH4fqkr2cx56EeyUyPmftS4JQYp9iTqHs4jU=;
        b=q/8gy9X1uG+iYW/dJGVZdqZ6h90pMAPxQyfm8Gm+oQr7ZjwdRqOE5ADEeyKwgcudAy
         t0laZ8B6M1hg9PwnDAZCBF8oamQh5kA5CzLzEF6MITIny+MjYpVwznvIMO4egXfXwCJd
         U49PVlQ1kwA/JluEJoWV2XHBFNBeNJ/MjXy2HUipVY89l3W+ckxal4VqRa2q2UAfmoiq
         pU7OQLuGXQDnfgz6Va8sDi78mv9opf2Y5S83EjTD5SdirUwVlmZNu4BOV7Q6mY975WAp
         JXhkeg2HtaMObGA2GNU5MJ+zY5k5qxBozyWLuqfq+YFdaCkzc3YXSR7t/JmP+Ly7c/aG
         xSVA==
X-Gm-Message-State: AOJu0Yz0SQBAdOOB4I7D4aYQIyMMYKEf+npY6fjSVQ3+7+TGR0YOfVUf
	P8+XD7PilmJ0G1qeLXWZUFWxA6sNIFkCNgTJGb281xroqNwb55ifmZXH5w3di8TVUwJRM7Q2WV6
	mGA==
X-Google-Smtp-Source: AGHT+IFD2bxvnxC7BpQTp8KmxRVWUA+M/qBIDa14XXXsuIVQO9Nh3SCU2daAzOIynb5YUxw92RfoxQ==
X-Received: by 2002:a17:902:d4c5:b0:1d9:3524:3db2 with SMTP id o5-20020a170902d4c500b001d935243db2mr18895plg.11.1707157039512;
        Mon, 05 Feb 2024 10:17:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsxPxLfa2k54v4x5TlGXwZXe1WxnrM5K3MasLtL0cn2JrO90COHkhNgnl0vzB4rw8viOinysHy90WT9cQUFcQ6O9UaCggIf1lU7qbfzQDBZr030iGczwa7K6KT+uEu65oRoPDEplBeOa5TyGGVStwXwXfNYunUe9lZ6ERNKkEcf+gIeacpu8Vp/L6J9PPeAzyzvPUatk53kMeBle07NNZjUZpDKOKwY4hBjLe+1Z25eVfNgftx69+ucJk8fRrb82c/zsKOFSYIV5F4cjUCdfSemDq6
Received: from [2620:0:1008:15:1e99:232a:d721:3dff] ([2620:0:1008:15:1e99:232a:d721:3dff])
        by smtp.gmail.com with ESMTPSA id ch11-20020a17090af40b00b00296a265acbbsm2117063pjb.25.2024.02.05.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:17:19 -0800 (PST)
Date: Mon, 5 Feb 2024 10:17:18 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: joro@8bytes.org, will@kernel.org, pasha.tatashin@soleen.com, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Message-ID: <0ffc92e6-9640-293b-8fbf-b2e45badad91@google.com>
References: <cover.1707144953.git.robin.murphy@arm.com> <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Robin Murphy wrote:

> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: David Rientjes <rientjes@google.com>
