From: Andreas Degert <andreas.degert-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: soundcard (dma) stopped working with commit 27c2127
	(x86/amd-iommu: Use only per-device dma_ops)
Date: Wed, 27 Mar 2013 08:14:58 +0100
Message-ID: <CAHccUr+MkODo0_Tci9sDEyXNBHu7CyqnVCamauvDESC_QL22HQ@mail.gmail.com>
References: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ@mail.gmail.com>
	<20130326094930.GD13035@8bytes.org>
	<CAHccUr+w1_65uBXLcmZLrPOgbC8Ldk8+PKxaRLv03rBYxBRDkg@mail.gmail.com>
	<20130326142336.GE13035@8bytes.org>
	<CAHccUrKmtjqBZVb1+1O5c4j6_9Er5Ow4tPRhExCW-g_kaV1-3A@mail.gmail.com>
	<20130326161132.GF2727@8bytes.org>
	<CAHccUrKpMiY4DURL_V2fPD8anz3T8WQT2_0PABu87mCzokpaWA@mail.gmail.com>
	<20130326203054.GA30540@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130326203054.GA30540-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

2013/3/26 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> Okay, thanks for trying this out. I think I know where the problem is,
> can you try the attached patch (without my debug-patch) and report me
> whether it fixes the issue?

Yes, works. What is the value of archdata.dma_ops before the assignment
and where is it set? (my hack to set the global variable dma_ops seems to
change that value.)

thanks
Andreas
