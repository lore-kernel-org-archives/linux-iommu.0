Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1E17E2
	for <iommu@lists.linux.dev>; Tue,  6 Dec 2022 03:13:40 +0000 (UTC)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NR54s13DNzJp5S;
	Tue,  6 Dec 2022 11:10:05 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 11:13:33 +0800
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
To: Gerd Bayer <gbayer@linux.ibm.com>, Barry Song <song.bao.hua@hisilicon.com>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
CC: Joerg Roedel <joro@8bytes.org>, Shuah Khan <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
Date: Tue, 6 Dec 2022 11:13:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221205135022.49708-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected


在 2022/12/5 21:50, Gerd Bayer 写道:
> Since [1] the user-space program dma_map_benchmark shares the header file
> linux/map_benchmark.h with the kernel driver in kernel/dma/map_benchmark.c.
> With latest kernel version this does not compile any more.
>
> While https://kernelnewbies.org/KernelHeaders suggests otherwise, allow it
> to use of kernel headers through the uapi/ include direcotry. I assume we can
> do so safely, since the controlling user-space program is distributed with
> the kernel.
>
> With this change dma_map_benchmark compiles with just the obvious warning
> about uapi usage on ARCH=x86 and s390 and runs on ARCH=s390.
>
> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

It also solves the compile error on arm64 platform.
Acked-by:  Xiang Chen <chenxiang66@hisilicon.com>

> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 5c997f17fcbd..d49d7ea6a63e 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -10,7 +10,7 @@
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
> -#include <linux/types.h>
> +#include <uapi/linux/types.h>
>   #include <linux/map_benchmark.h>
>   
>   #define NSEC_PER_MSEC	1000000L
>
> base-commit: 8abacb3356e68261ccd3a2ad74ed6042363e5d0f

