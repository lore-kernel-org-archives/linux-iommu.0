From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Haswell IOMMU bug that gets no response from maintainers
Date: Thu, 7 Apr 2016 09:26:19 +0500
Message-ID: <5705E16B.3070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hello.

In August 2013, I have reported this bug: 
https://bugzilla.kernel.org/show_bug.cgi?id=60769 . It has been 
determined on October 2013 to be a bug with IOMMU. The bug manifests 
itself as either unreliable or completely non-working HDMI audio on 
Haswell systems.

However, there have been no reaction of IOMMU experts to the bug, except 
two messages from David Woodhouse in November 2013. On PulseAudio 
mailing list and IRC channel we still have affected users (who blame 
PulseAudio and thus spread FUD), and I myself have to apply the 
"iommu=on,igfx_off" workaround.

Where and how do I escalate the bug? What other info (except DMAR dumps 
which are already in the bug) is needed?

-- 
Alexander E. Patrakov
