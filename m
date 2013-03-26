From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: soundcard (dma) stopped working with commit 27c2127
	(x86/amd-iommu: Use only per-device dma_ops)
Date: Tue, 26 Mar 2013 15:23:36 +0100
Message-ID: <20130326142336.GE13035@8bytes.org>
References: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ@mail.gmail.com>
	<20130326094930.GD13035@8bytes.org>
	<CAHccUr+w1_65uBXLcmZLrPOgbC8Ldk8+PKxaRLv03rBYxBRDkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHccUr+w1_65uBXLcmZLrPOgbC8Ldk8+PKxaRLv03rBYxBRDkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Degert <andreas.degert-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Andreas,

thanks for the information.

On Tue, Mar 26, 2013 at 01:48:38PM +0100, Andreas Degert wrote:
> seems to be this (additionaly I have appended the full dump):
> 
> device: 00:00.2 cap: 0040 seg: 0 flags: fe info 1300
>           mmio-addr: 00000000feb80000
>    DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
>    DEV_RANGE_END           devid: ff:1f.6
>    DEV_ALIAS_RANGE        devid: 03:00.0 flags: 00 devid_to: 00:14.4
>    DEV_RANGE_END           devid: 04:1f.7
>    DEV_SPECIAL(HPET[0])   devid: 00:14.0
>    DEV_SPECIAL(IOAPIC[5]) devid: 00:14.0

That looks good so far. You have two sound devices:

	One in the GPU at 00:01.1
	One in the SB at 00:14.2

Both are covered by the above IVRS entries. Does a unpatched kernel (no
rt patch) work for you, so can you try if it also happens with 3.8.4?

So you see IO_PAGE_FAULTS when trying to use the soundcard?

Thanks,

	Joerg
