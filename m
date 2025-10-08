Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5792848AF
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930205; cv=none; b=K/9qKgLxpIG6nTYWrTt1ZECXd1VGZlM64Z/fqegn7l/oXSGUowfP2hKG71pjHuHZUOmNlqMMUpL9ApCvj9qmSVibq0pgbfU2x85auHvyMaxTygir6s0FkdhCjg2xFPb0bsMXTcGsABVeOXOLT4Pmuh5iJDK9JEU9Gpm3uwmn14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930205; c=relaxed/simple;
	bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA0QKjbVHTEo+A3hmPW0eE+Y84BBwa5DpmMsRQ8R6mg+0Ix/EhrFpy40D76NNSwG/zAo5Y1A9lluXEZEO8SfnhD18CUrRhDhtu1yEC8lTlfl4G7iBSc+8L4ZTldGG5OSyLhm69FYcmTw9oneT/DqoeLqOfmA+TTuXP74chR0w2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UlTeEc9X; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UlTeEc9X"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f554ed252so3686459b6e.0
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759930203; x=1760535003; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=UlTeEc9XDj/k75ZbgsRCR6Uhk1jK2LcNtrn4kIZkEXEODpjgGdkKtQbBv0w+CpYcXN
         zyjh8kQ8JOfTIYqMY5ny2k0IVXzjRhlrChXQr8AFzigJgiAKJrKmwzKCWq0JklaaSZvA
         K13H+e5qAhnodHul/7C1BsRFZOAyTJU1GGBrYY7sytJbuwDuhjbz1XYiWJVOvnL9JusB
         sH53tU2hbnQvQClYZXHCfvdgnlE26CDhhfxkcCK7jRys50POMDZdDZ+NagP0VeAOksg1
         ZBLA+0rQL9kXvkX8GNpRF2yQCBFyK/OBk899nfFdNWKFioXKIt8jVZisY61HKAI8xuly
         2kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930203; x=1760535003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=iFmGZ/g9aZBc4NJ0VvmodF7lNwcOAdiNMLXUkZ3ttnf2Kd3xh1f48yojY0VGpLimwJ
         u500JWKWg5nV05Q8wqgXBcOzUKfcdm9HHquQt3zblBc+xr37a75o5IB4tUxaStQmrF0x
         EvHkpEfmHpCikhNFYnlrneKpIuRFuvFTf/G4qpsX/DnGSJKLq8sSiXmD44MG29gIPBTu
         eDnYX8U915VSgRgaGmnIrpoBMkjaybFLIax8ioSFD32lkTp4lQV8t+cwFMUr1/MG+OTi
         TqwrznnvCCXewhn/wUgNfL/qmm0tjo2tbdcuPTmylIyC4Snef3gaqN8XE6o+V8PFPEpj
         6Big==
X-Forwarded-Encrypted: i=1; AJvYcCV+qbJXikbfNF+f7B0bZcPiyie/wYRwr/ZOb7hUmzQz+FyFAxiqDPdTM1RSiZuRM+BjQkmyyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPxCv39LrGe0NVft0sX73xMfeZlQxpCpV3fMOdFkZsUfCyR/I8
	ukeUoMIvk5OqjLTuZjGc0aoya/iLKiYKFNoltfJW/7H7VCGW+CRBGXCk/1JrxUif1OE=
X-Gm-Gg: ASbGncs/WXEOpn3PEs7wkrvMTmmvRbf5dAvMIrB6pbjH9OmanUaYQsb+QUyXyoqzpYk
	0KVx2VdszTd1vp7x8ViMnAeo2YrtaJPE5G7hnjDGRh0VDZf70J3HiB1pfcKoAY9jJ/cdDmK78D5
	MQB89mfvO2gu4PSrLWLYHtMm8NUNJ0m342UWlJ8DWrFGI9htwZbbFogzWQYqne5J1I91XA8SC5q
	7UoTVAu/6qBxBKKbynYjcOEl/f1F6HKuVdsghW271Wo06/VuXEyaPKKi+qzhuUudkKc6x/T96bM
	Hc1gnDrZk4AoNsXUc1+JpvCWKS9OrH9WsuKrN2nK0kbuEjfqWfGXPu+jMLVSLvwW4kdHF6z2eco
	3qUGTXlkHiUoWM5ZQdsonaC57Rp2v95Ya
X-Google-Smtp-Source: AGHT+IEHXHi1fX92viHn1FlNncpYH+JLVa8oK1Fr/RFGZjN8SkFmL54M+5MvXjcHKBsxQCY4yNEe0g==
X-Received: by 2002:a05:6808:5245:b0:438:338b:edb with SMTP id 5614622812f47-4417b2f8ac5mr1803574b6e.12.1759930202725;
        Wed, 08 Oct 2025 06:30:02 -0700 (PDT)
Received: from ziepe.ca ([140.209.225.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcf749sm5768186a34.9.2025.10.08.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:30:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6UEy-0000000Fw7f-3aJ8;
	Wed, 08 Oct 2025 10:30:00 -0300
Date: Wed, 8 Oct 2025 10:30:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
Message-ID: <20251008133000.GB3734646@ziepe.ca>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
 <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
 <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>

On Wed, Oct 08, 2025 at 03:24:29PM +0200, Alessandro Zanni wrote:

> Let me know which version is preferable.

I already applied your fix for this, no need to resend

Jason
