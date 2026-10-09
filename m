Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BD342514;
	Fri,  9 Oct 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538056; cv=none; b=WEwhbkYQC7xYxGebHzBYWMI3EWyhrVn1Rm1MljwRYqaMDA3s4eQfP97q2VAFPGvuckXpI6PHecSz7pd0vd4lW03YwH4IgH1Fwl0TJtbv2tBre6/FOYBUk+UCOFcvpHByZie/h1b80mBzIp58tW9a7++raCBKK+TIuA3QZ6nWd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538056; c=relaxed/simple;
	bh=VzHE6sfBCfn7lqlC5cHQiEZhMNffUx9scn7YhfPiWwQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CZpCR4hHvmJ4HJq+b8UMfxyFjbD6zw3xDEbh2JIhXz/pkQBQXQx/rMjFhaJyzMXG4H2jlzmBFV/iRzQJIRZDk/V8/ICQQZJCch8y47UkAf4ip2MikuFauGInHMmjfEKWyDvbsO98iGCtjerNalGYix6G9iKU3mYPzQZCVNy0LYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPuqMM3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPuqMM3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFD01F000FF;
	Fri,  9 Oct 2026 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791538055;
	bh=gbs+O3il6AZ+b47/QZ+p2Di1T0JcIDp2VboXRYCu+d0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XPuqMM3d1Qi1aZndxPFwZ/pv1ON3DCmT9vbtpoTfmZ0DbNrNzqxp9MmQtN0N7lPNw
	 82MbsFLUXNFWqsLNWTIeQyabxtAvVTfoXJGUWI+AEpbGGxxMYAER/TX8+e1lW6nMPY
	 Jzx+LAcudYMXMgCVaPA4JZlnN7gZ4Z9vrrMzeksTa7H2qjblAzli0MZl2d8uE1qyQA
	 QckkWsP64wDafUqmti14ZWy3t5vdgAWbtsI+W9V5u9ZNXGpnZXPlB2CD6N4kH31aog
	 QRwhOHIfnFKlitWENMC4AFSdg3vcgV5ShD6F3ddnUt1h0UiRZaVgs4xHLx2iud6clQ
	 OmtlkWckQ1HDA==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for
 "iommu-ranges" on a device node
From: bod@kernel.org
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev, 
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 10:27:28 +0100
Message-Id: <179153804819.2596899.5363254526911327543.b4-reply@b4>
X-Mailer: b4 0.17-dev-e5aa4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=bod@kernel.org;
 h=from:subject:message-id; bh=VzHE6sfBCfn7lqlC5cHQiEZhMNffUx9scn7YhfPiWwQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqyLOAWpqazRvXBDloXY25XV4lXHcaFmGj5ELii
 bSVcf0LYN2JAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasizgAAKCRAicTuzoY3I
 OmPGEACoJWqpXTUeA2xXyByyk9UwsfAtwy0Vci6LkFvoGik4pIdt3Mj4H0QrW47lTxZQbZrz13o
 JgNkLcd3oIfuAo6ClboHAkkNAWgCXKUMzeRo4J1UMDkdJ6Oos2J+IB5oPdk9AIGa6GsvHdVn5mV
 1zDuC/YO7yEB7+bjoe4WODTac1W2RPHYoH5PnUxA/Kx2CoJTMXWjQD56zxjS7ZRHChW6ZOtloB0
 2OtXE3dokqWksorCZmRcY7f1dvo7TiMpt+5s1pVYEgf9yI2NBDeJrjxE0sZWJsqwTodfjYHHvZy
 zC7J2NqUfsGpAA3QMVWOIXaPTdl3k/7VTW4H+3l9px4EbzrBYLWalfCfDJzq5SHEmyKb14NcBT8
 73rAofB5fr34cxBEHNbTAmR3m5P2ZqClcj1nHmWLMad9utVP/qLJfTzBb/X67GXBLSBp8Sz1VG9
 3XzRJkoGTejRplbYuqqWowxbZxmyzSOP/qrs1KyuH4JBHzkggwdjk4qymT1fyd58ICBWSucqxXN
 C5dNV0/VqAO8mknnCZnvpu/2lKDak0StqWY/ae3Ngo+nNdU5lOCDHSSSkh/5sZwke/JtDPh4vUh
 BxQZdZMH+44CGjw/y4osw/pd/RGobUggsnXRy/WJSl1xec+fF6XURJzss778pS7dh1yl4fH4ice
 m0C+Fa086hPiOTw==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-09-26 12:04 +0530, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> Introduce a new property, "iommu-ranges", to specify the device
> specific IOVA ranges when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

I think we need to get buy-in from the IOMMU people on this change before
we commit to bindings that may be affected by a rejection.

i.e. There's no point in absorbing potentially DOA bindings.
---
bod

