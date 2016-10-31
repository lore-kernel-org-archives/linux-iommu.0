From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] swiotlb: Rate-limit printing when running out of
 SW-IOMMU space
Date: Mon, 31 Oct 2016 19:02:38 +0300
Message-ID: <6651130c-9c13-5ba5-879a-1a8189472b7c@cogentembedded.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
 <1477928704-10611-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1477928704-10611-2-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 10/31/2016 06:45 PM, Geert Uytterhoeven wrote:

> If the system runs out of SW-IOMMU space, changes are high successive

    s/changes/chances/?

> requests will fail, too, flooding the kernel log.  This is true
> especially for streaming DMA, which is typically used repeatedly outside
> the driver's initialization routine.  Add rate-limiting to fix this.
>
> While at it, get rid of the open-coded dev_name() handling by using the
> appropriate dev_err_*() variant.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei

