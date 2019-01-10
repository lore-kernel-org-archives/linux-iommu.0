From: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to
	command line
Date: Thu, 10 Jan 2019 12:27:36 -0500
Message-ID: <CAPbh3rupHC_G0=5dBhhpoXvXO_=i-Y6p=9WdRtn9W19jRpVVcg@mail.gmail.com>
References: <1543832571-121638-1-git-send-email-zhe.he@windriver.com>
	<b35907a9-4d30-493b-3839-731b10d71c63@windriver.com>
	<20190107090702.GA14033@lst.de>
Reply-To: konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4260317914337623314=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190107090702.GA14033-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4260317914337623314==
Content-Type: multipart/alternative; boundary="000000000000aa0fa1057f1de52b"

--000000000000aa0fa1057f1de52b
Content-Type: text/plain; charset="UTF-8"

Let's skip it. There was another patch that would allocate a default 4MB
size if it there was an misue of swiotlb parameters.



On Mon, Jan 7, 2019, 4:07 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org wrote:

> On Mon, Jan 07, 2019 at 04:46:51PM +0800, He Zhe wrote:
> > Kindly ping.
>
> Konrad, I'll pick this up through the DMA mapping tree unless you
> protest in the next few days.
>

--000000000000aa0fa1057f1de52b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Let&#39;s skip it. There was another patch that woul=
d allocate a default 4MB size if it there was an misue of swiotlb parameter=
s.<div dir=3D"auto"><br></div><br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Mon, Jan 7, 2019, 4:07 AM Christoph Hellwig &lt;<a href=3D"mail=
to:hch-jcswGhMUV9g@public.gmane.org">hch-jcswGhMUV9g@public.gmane.org</a> wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">On Mon, Jan 07, 2019 at 04:46:51PM +0800, He Zhe wrote:<br>
&gt; Kindly ping.<br>
<br>
Konrad, I&#39;ll pick this up through the DMA mapping tree unless you<br>
protest in the next few days.<br>
</blockquote></div></div></div>

--000000000000aa0fa1057f1de52b--

--===============4260317914337623314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4260317914337623314==--
