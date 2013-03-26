From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: soundcard (dma) stopped working with commit 27c2127
	(x86/amd-iommu: Use only per-device dma_ops)
Date: Tue, 26 Mar 2013 10:49:30 +0100
Message-ID: <20130326094930.GD13035@8bytes.org>
References: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tue, Mar 26, 2013 at 08:37:02AM +0100, Andreas Degert wrote:
> Does anyone have some advice for further debugging?

Can you please boot with amd_iommu_dump on the kernel command line and
send dmesg after boot? This will print the parsing output of the IVRS
table to dmesg which will help debugging this problem.

Also, can you share what mainboard you have?

Thanks,

	Joerg
