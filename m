From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: soundcard (dma) stopped working with commit 27c2127
	(x86/amd-iommu: Use only per-device dma_ops)
Date: Wed, 27 Mar 2013 09:28:22 +0100
Message-ID: <20130327082822.GJ30540@8bytes.org>
References: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ@mail.gmail.com>
	<20130326094930.GD13035@8bytes.org>
	<CAHccUr+w1_65uBXLcmZLrPOgbC8Ldk8+PKxaRLv03rBYxBRDkg@mail.gmail.com>
	<20130326142336.GE13035@8bytes.org>
	<CAHccUrKmtjqBZVb1+1O5c4j6_9Er5Ow4tPRhExCW-g_kaV1-3A@mail.gmail.com>
	<20130326161132.GF2727@8bytes.org>
	<CAHccUrKpMiY4DURL_V2fPD8anz3T8WQT2_0PABu87mCzokpaWA@mail.gmail.com>
	<20130326203054.GA30540@8bytes.org>
	<CAHccUr+MkODo0_Tci9sDEyXNBHu7CyqnVCamauvDESC_QL22HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHccUr+MkODo0_Tci9sDEyXNBHu7CyqnVCamauvDESC_QL22HQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Mar 27, 2013 at 08:14:58AM +0100, Andreas Degert wrote:
> 2013/3/26 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> > Okay, thanks for trying this out. I think I know where the problem is,
> > can you try the attached patch (without my debug-patch) and report me
> > whether it fixes the issue?
> 
> Yes, works. What is the value of archdata.dma_ops before the assignment
> and where is it set? (my hack to set the global variable dma_ops seems to
> change that value.)

It is a little bit different. When the per-device dma_ops is not set the
global one will be used. Your fix set the global one which hides the
bug, that the per-device one was not set in this case.


	Joerg
