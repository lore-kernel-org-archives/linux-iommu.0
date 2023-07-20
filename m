Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE61428A
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B2C433C7;
	Thu, 20 Jul 2023 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689835064;
	bh=WAO1d9bOJCbUb/DNvoZTMUNW6vHRM+6002B/Y46guJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X3Cn2wYARSyhjih+emk8w/BnmlMuyyVrIDOF9A6AxsvEKgshgmN1XMcf+CvvOoi5H
	 qyYCeb4WHQie6th3DBjwLHOyRT+flCEm8HqqJd+PN7zrSWzZ8U1JJ/YGX5hpkSayyj
	 pooaN9Qe5ONjIrPu320OyBESzMrjnw2jLFHmlcFVMY/NYwm3zJY1hF1AjPk74bN8i5
	 7ZCSWXNtpdp2PE9bGesQqp5aYsBmyBqxNznAaRkZuNBCd1wj3ZF27btVT5w3UPfNje
	 MUQ0m1q4svlr7Gy9W1exWmidYdVCKshEWZ01HYjMvRXez9PdYF8m4F44rXmp2IXz/L
	 0ttDKeyBtJXkg==
Message-ID: <b3b3b21b-37e8-bd6f-6e4c-7ad9bd47446d@kernel.org>
Date: Thu, 20 Jul 2023 08:37:36 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU
 support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Anup Patel <apatel@ventanamicro.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
 linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
 iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
 Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
 <20230719-marbled-drivable-804aacbafee2@spud>
 <CAH2o1u4107Eve67gxEg1rtCLFyaABFsmfop1-ko=GT5wzeajiQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAH2o1u4107Eve67gxEg1rtCLFyaABFsmfop1-ko=GT5wzeajiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/07/2023 23:07, Tomasz Jeznach wrote:
> On Wed, Jul 19, 2023 at 1:22 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Wed, Jul 19, 2023 at 12:33:46PM -0700, Tomasz Jeznach wrote:
>>
>> $subject: RISC-V: arch/riscv/config: enable RISC-V IOMMU support
>>
>> Please look at any other commits to the files you are touching
>> and use a subject line that emulates them. In this case, try
>> git log --oneline --no-merges -- arch/riscv/configs/
>> Same goes for the odd pattern in your driver patches.
>>
>> Also, the patch may be trivial, but you still need to sign off on it
>> and provide a commit message.
>>
> 
> ack. added to-do the list for v2.

Please run checkpatch before sending.

Best regards,
Krzysztof

